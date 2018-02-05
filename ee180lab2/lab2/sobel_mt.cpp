#include <stdio.h>
#include <stdlib.h>
#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/highgui/highgui.hpp"
#include <iostream>
#include <fstream>
#include <errno.h>
#include <unistd.h>
#include <string.h>
#include <locale.h>
#include <sys/ioctl.h>
#include <err.h>

#include "sobel_alg.h"
#include "pc.h"

// Replaces img.step[0] and img.step[1] calls in sobel calc

using namespace cv;

static ofstream results_file;

// Define image mats to pass between function calls
static Mat img_gray, img_sobel, img_gray_top, img_gray_bot, img_sobel_top, img_sobel_bot, topsrc, botsrc;
static float total_fps, total_ipc, total_epf;
static float gray_total, sobel_total, cap_total, disp_total;
static float sobel_ic_total, sobel_l1cm_total;
static CvCapture* video_cap;
static int max_frames;
/*******************************************
 * Model: runSobelMT
 * Input: None
 * Output: None
 * Desc: This method pulls in an image from the webcam, feeds it into the
 *   sobelCalc module, and displays the returned Sobel filtered image. This
 *   function processes NUM_ITER frames.
 ********************************************/

void *runSobelMT(void *ptr)
{
  // Set up variables for computing Sobel
  string top = "Sobel Top";
  Mat src;
  uint64_t cap_time, gray_time, sobel_time, disp_time, sobel_l1cm, sobel_ic;
  pthread_t myID = pthread_self();
  counters_t perf_counters;

  // Allow the threads to contest for thread0 (controller thread) status
  pthread_mutex_lock(&thread0);

  // Check to see if this thread is first to this part of the code
  if (thread0_id == 0) {
    thread0_id = myID;
  }
  pthread_mutex_unlock(&thread0);

  // For now, we just kill the second thread. It's up to you to get it to compute
  // the other half of the image.

  // Start algorithm
  if (myID == thread0_id) {
    pc_init(&perf_counters, 0);

    if (opts.webcam) {
      video_cap = cvCreateCameraCapture(-1);
    } else {
      video_cap = cvCreateFileCapture(opts.videoFile);
    }

    cvSetCaptureProperty(video_cap, CV_CAP_PROP_FRAME_WIDTH, IMG_WIDTH);
    cvSetCaptureProperty(video_cap, CV_CAP_PROP_FRAME_HEIGHT, IMG_HEIGHT);

    max_frames = opts.numFrames;
  }
  // Keep track of the frames
  int i = 0;

  while (1) {
    if (myID == thread0_id) {
      // Allocate memory to hold grayscale and sobel images
      img_gray_top = Mat(IMG_HEIGHT/2 + 1, IMG_WIDTH, CV_8UC1);
      img_sobel_top = Mat(IMG_HEIGHT/2 + 1, IMG_WIDTH, CV_8UC1);
      img_gray_bot = Mat(IMG_HEIGHT - IMG_HEIGHT/2 + 1, IMG_WIDTH, CV_8UC1);
      img_sobel_bot = Mat(IMG_HEIGHT - IMG_HEIGHT/2 + 1, IMG_WIDTH, CV_8UC1);
      img_sobel = Mat(IMG_HEIGHT, IMG_WIDTH, CV_8UC1);

      pc_start(&perf_counters);
      src = cvQueryFrame(video_cap);

      //split frame in two for each worker
      Rect toprec(0, 0, src.cols, (src.rows / 2) + 1);
      Rect botrec(0, src.rows / 2 - 1, src.cols, src.rows - src.rows / 2 + 1);
      topsrc = src(toprec);
      botsrc = src(botrec);

      pc_stop(&perf_counters);

      cap_time = perf_counters.cycles.count;
      sobel_l1cm = perf_counters.l1_misses.count;
      sobel_ic = perf_counters.ic.count;
    }
    pthread_barrier_wait(&startSobel);

    // LAB 2, PART 2: Start parallel section
    if (myID == thread0_id){
      pc_start(&perf_counters);
      grayScale(topsrc, img_gray_top);
      pc_stop(&perf_counters);
    }
    else{ grayScale(botsrc, img_gray_bot); }

    if (myID == thread0_id){
      gray_time = perf_counters.cycles.count;
      sobel_l1cm += perf_counters.l1_misses.count;
      sobel_ic += perf_counters.ic.count;
    }

    if (myID == thread0_id){
      pc_start(&perf_counters);
      sobelCalc(img_gray_top, img_sobel_top);
      pc_stop(&perf_counters);
    }
    else{ sobelCalc(img_gray_bot, img_sobel_bot); }

    pthread_barrier_wait(&endSobel);

    if (myID == thread0_id){
      sobel_time = perf_counters.cycles.count;
      sobel_l1cm += perf_counters.l1_misses.count;
      sobel_ic += perf_counters.ic.count;

      pc_start(&perf_counters);
      //join the two mats
      Rect toprec(0, 0, img_sobel_top.cols, img_sobel_top.rows - 1);
      Rect botrec(0, 1, img_sobel_bot.cols, img_sobel_bot.rows - 2);
      img_sobel_top = img_sobel_top(toprec);
      img_sobel_bot = img_sobel_bot(botrec);
      vconcat(img_sobel_top, img_sobel_bot, img_sobel);

    // LAB 2, PART 2: End parallel section

      namedWindow(top, CV_WINDOW_AUTOSIZE);
      imshow(top, img_sobel);
      pc_stop(&perf_counters);

      disp_time = perf_counters.cycles.count;
      sobel_l1cm += perf_counters.l1_misses.count;
      sobel_ic += perf_counters.ic.count;

      cap_total += cap_time;
      gray_total += gray_time;
      sobel_total += sobel_time;
      sobel_l1cm_total += sobel_l1cm;
      sobel_ic_total += sobel_ic;
      disp_total += disp_time;
      total_fps += PROC_FREQ/float(cap_time + disp_time + gray_time + sobel_time);
      total_ipc += float(sobel_ic/float(cap_time + disp_time + gray_time + sobel_time));
      i++;


    // Press q to exit
      char c = cvWaitKey(1);
      if (c == 'q'){
        break;
      }
    }
    if(i >= max_frames){
      break;
    }
  }

  if(myID == thread0_id){
    total_epf = PROC_EPC*NCORES/(total_fps/i);
    float total_time = float(gray_total + sobel_total + cap_total + disp_total);

    results_file.open("mt_perf.csv", ios::out);
    results_file << "Percent of time per function" << endl;
    results_file << "Capture, " << (cap_total/total_time)*100 << "%" << endl;
    results_file << "Grayscale, " << (gray_total/total_time)*100 << "%" << endl;
    results_file << "Sobel, " << (sobel_total/total_time)*100 << "%" << endl;
    results_file << "Display, " << (disp_total/total_time)*100 << "%" << endl;
    results_file << "\nSummary" << endl;
    results_file << "Frames per second, " << total_fps/i << endl;
    results_file << "Cycles per frame, " << total_time/i << endl;
    results_file << "Energy per frames (mJ), " << total_epf*1000 << endl;
    results_file << "Total frames, " << i << endl;
    results_file << "\nHardware Stats (Cap + Gray + Sobel + Display)" << endl;
    results_file << "Instructions per cycle, " << total_ipc/i << endl;
    results_file << "L1 misses per frame, " << sobel_l1cm_total/i << endl;
    results_file << "L1 misses per instruction, " << sobel_l1cm_total/sobel_ic_total << endl;
    results_file << "Instruction count per frame, " << sobel_ic_total/i << endl;

    cvReleaseCapture(&video_cap);
    results_file.close();
  }
  pthread_barrier_wait(&endSobel);
  return NULL;
}
