#include "opencv2/imgproc/imgproc.hpp"
#include "sobel_alg.h"
#include <arm_neon.h>
using namespace cv;

/*******************************************
 * Model: grayScale
 * Input: Mat img
 * Output: None directly. Modifies a ref parameter img_gray_out
 * Desc: This module converts the image to grayscale
 ********************************************/
void grayScale(Mat& img, Mat& img_gray_out)
{
  const int rows = img.rows;//640x480
  const int cols = img.cols;//step1 = 3 for 3 contiguous RGB values
  uint8_t*arr_red =  img.data;
  unsigned char* output_arr = img_gray_out.data;
  // Convert to grayscale
//  for (int i = 0; i < rows*cols; i++) {
//	output_arr[i] = .114*arr_red[STEP1*i] + .587*arr_red[STEP1*i + 1] + .299*arr_red[STEP1*i+2];
  //}

  for (int i=0; i<rows*cols/8; i++) {
          uint8x8x3_t vec = vld3_u8(arr_red + 24*i);
          uint8x8_t vec_output = vshr_n_u8(vec.val[0],3);
	  vec_output = vsub_u8(vec_output,vshr_n_u8(vec.val[0],6)); //.109 (error:.006)
          vec_output = vadd_u8(vec_output,vshr_n_u8(vec.val[1],1));
	  vec_output = vadd_u8(vec_output, vshr_n_u8(vec.val[1],4));
	  vec_output = vadd_u8(vec_output, vshr_n_u8(vec.val[1],5));//.593 (error .006)
	  vec_output = vadd_u8(vec_output, vshr_n_u8(vec.val[2],2));
	  vec_output = vadd_u8(vec_output, vshr_n_u8(vec.val[2],4));
	  vec_output = vsub_u8(vec_output, vshr_n_u8(vec.val[2],6));//.296 (error .003) 
          vst1_u8(output_arr + 8*i, vec_output);
   }

}

/*******************************************
 * Model: sobelCalc
 * Input: Mat img_in
 * Output: None directly. Modifies a ref parameter img_sobel_out
 * Desc: This module performs a sobel calculation on an image. It first
 *  converts the image to grayscale, calculates the gradient in the x
 *  direction, calculates the gradient in the y direction and sum it with Gx
 *  to finish the Sobel calculation
 ********************************************/
void sobelCalc(Mat& img_gray, Mat& img_sobel_out)
{
  Mat img_outx = img_gray.clone();
  Mat img_outy = img_gray.clone();

  // Apply Sobel filter to black & white image
  unsigned short sobel;

  // Calculate the x convolution
  int rows = img_gray.rows;
  int cols = img_gray.cols;
  uint8_t* baseptr = img_gray.data;
  
  for (int i = 1; i<rows; i++) {
	for(int j = 0; j<cols/8; j++) {
		uint8x8_t vtopleft = vld1_u8(baseptr + IMG_WIDTH*(i-1) + (8*(j)));
		uint8x8_t vbotleft = vld1_u8(baseptr+IMG_WIDTH*(i+1) + (8*(j)));
		uint8x8_t vtopcent = vld1_u8(baseptr+IMG_WIDTH*(i-1) + (8*(j)+1));
		uint8x8_t vbotcent = vld1_u8(baseptr+IMG_WIDTH*(i+1) + (8*(j)+1));
		uint8x8_t vtopright = vld1_u8(baseptr+IMG_WIDTH*(i-1) + (8*(j)+2));
		uint8x8_t vbotright = vld1_u8(baseptr+IMG_WIDTH*(i+1) + (8*(j)+2));
		uint8x8_t vcentleft = vld1_u8(baseptr+IMG_WIDTH*i + (8*(j)));
		uint8x8_t vcentright = vld1_u8(baseptr+IMG_WIDTH*i + (8*(j)+2));
		uint16x8_t sobel = vaddl_u8(vtopleft,vtopleft);
		sobel = vaddw_u8(sobel, vtopcent);
		sobel = vaddw_u8(sobel, vtopcent);
		sobel = vsubw_u8(sobel, vbotcent);
		sobel = vsubw_u8(sobel, vbotcent);
		sobel = vaddw_u8(sobel, vcentleft);
		sobel = vaddw_u8(sobel, vcentleft);
		sobel = vsubw_u8(sobel, vcentright);
		sobel = vsubw_u8(sobel, vcentright);
		sobel = vsubw_u8(sobel, vbotright);
		sobel =  vsubw_u8(sobel, vbotright);
		/*uint16x8_t sobelx = vaddl_u8(vtopleft,vtopright);
		sobelx = vaddw_u8(sobelx, vtopcent);
		sobelx = vaddw_u8(sobelx, vtopcent);
		sobelx = vsubw_u8(sobelx, vbotcent);
		sobelx = vsubw_u8(sobelx, vbotcent);
		sobelx = vsubw_u8(sobelx, vbotright);
		sobelx = vsubw_u8(sobelx, vbotleft);
		uint16x8_t sobely = vaddl_u8(vtopleft, vbotleft);
		sobely = vaddw_u8(sobely, vcentleft);
		sobely = vaddw_u8(sobely, vcentleft);
		sobely = vsubw_u8(sobely, vcentright);
		sobely = vsubw_u8(sobely, vcentright);
		sobely = vsubw_u8(sobely, vtopright);
		sobely = vsubw_u8(sobely, vbotright);
		//uint16x8_t sobel = sobelx + sobely;*/  
		vst1_u8(img_sobel_out.data + IMG_WIDTH*i + 8*j, vreinterpret_u8_s8(vqmovn_s16(vabsq_s16(vreinterpretq_s16_u16(sobel)))));
		//vst1_u8(img_outx.data + IMG_WIDTH*i + 8*j + 1, vreinterpret_u8_s8(vqmovn_s16(vabsq_s16(vreinterpretq_s16_u16(sobelx)))));
	//	vst1_u8(img_outy.data + IMG_WIDTH*i + 8*j + 1, vreinterpret_u8_s8(vqmovn_s16(vabsq_s16(vreinterpretq_s16_u16(sobely)))));
	}
}

/*
  for (int i=1; i<img_gray.rows; i++) {
    for (int j=1; j<img_gray.cols; j++) {
      sobel = abs(img_gray.data[IMG_WIDTH*(i-1) + (j-1)] -
		  img_gray.data[IMG_WIDTH*(i+1) + (j-1)] +
		  2*img_gray.data[IMG_WIDTH*(i-1) + (j)] -
		  2*img_gray.data[IMG_WIDTH*(i+1) + (j)] +
		  img_gray.data[IMG_WIDTH*(i-1) + (j+1)] -
		  img_gray.data[IMG_WIDTH*(i+1) + (j+1)]);

      sobel = (sobel > 255) ? 255 : sobel;
      img_outx.data[IMG_WIDTH*(i) + (j)] = sobel;
    }
  }

  
// Calc the y convolution
  for (int i=1; i<img_gray.rows; i++) {
    for (int j=1; j<img_gray.cols; j++) {
     sobel = abs(img_gray.data[IMG_WIDTH*(i-1) + (j-1)] -
		   img_gray.data[IMG_WIDTH*(i-1) + (j+1)] +
		   2*img_gray.data[IMG_WIDTH*(i) + (j-1)] -
		   2*img_gray.data[IMG_WIDTH*(i) + (j+1)] +
		   img_gray.data[IMG_WIDTH*(i+1) + (j-1)] -
		   img_gray.data[IMG_WIDTH*(i+1) + (j+1)]);

     sobel = (sobel > 255) ? 255 : sobel;

     img_outy.data[IMG_WIDTH*(i) + j] = sobel;
    }
  }

  // Combine the two convolutions into the output image
  for (int i=1; i<img_gray.rows; i++) {
    for (int j=1; j<img_gray.cols; j++) {
      sobel = img_outx.data[IMG_WIDTH*(i) + j] +
	img_outy.data[IMG_WIDTH*(i) + j];
      sobel = (sobel > 255) ? 255 : sobel;
      img_sobel_out.data[IMG_WIDTH*(i) + j] = sobel;
    }
  }*/
}
