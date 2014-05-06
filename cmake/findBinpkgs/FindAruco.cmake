INCLUDE_DIRECTORIES()
SET(aruco_INCLUDE_DIRS )

SET(aruco_LIBS opencv_contrib;opencv_legacy;opencv_stitching;opencv_gpu;opencv_objdetect;opencv_calib3d;opencv_features2d;opencv_video;opencv_highgui;opencv_ml;opencv_imgproc;opencv_flann;opencv_core) 
find_library(aruco_LIB aruco124 ${CMAKE_CURRENT_LIST_DIR}/lib/ )
SET(aruco_LIBS ${aruco_LIBS};${aruco_LIB})

SET(aruco_VERSION        1.2.4)
SET(aruco_VERSION_MAJOR  1)
SET(aruco_VERSION_MINOR  2)
SET(aruco_VERSION_PATCH  4)