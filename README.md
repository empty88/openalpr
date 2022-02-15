openalpr
========

OpenALPR is an open source *Automatic License Plate Recognition* library written in C++ with bindings in C#, Java, Node.js, Go, and Python.  The library analyzes images and video streams to identify license plates.  The output is the text representation of any license plate characters.

Check out a live online demo here: http://www.openalpr.com/demo-image.html

User Guide
-----------


OpenALPR includes a command line utility.  Simply typing "alpr [image file path]" is enough to get started recognizing license plate images.

For example, the following output is created by analyzing this image:
![Plate Image](http://www.openalpr.com/images/demoscreenshots/plate3.png "Input image")



```
user@linux:~/openalpr$ alpr ./samplecar.png

plate0: top 10 results -- Processing Time = 58.1879ms.
    - PE3R2X     confidence: 88.9371
    - PE32X      confidence: 78.1385
    - PE3R2      confidence: 77.5444
    - PE3R2Y     confidence: 76.1448
    - P63R2X     confidence: 72.9016
    - FE3R2X     confidence: 72.1147
    - PE32       confidence: 66.7458
    - PE32Y      confidence: 65.3462
    - P632X      confidence: 62.1031
    - P63R2      confidence: 61.5089

```

Documentation
---------------

Detailed documentation is available at [doc.openalpr.com](http://doc.openalpr.com/)

Integrating the Library
-----------------------

OpenALPR is written in C++ and has bindings in C#, Python, Node.js, Go, and Java.  Please see this guide for examples showing how to run OpenALPR in your application: http://doc.openalpr.com/bindings.html

Docker
------

``` shell
# Build docker image
docker build -t openalpr https://github.com/openalpr/openalpr.git
# Download test image
wget http://plates.openalpr.com/h786poj.jpg
# Run alpr on image
docker run -it --rm -v $(pwd):/data:ro openalpr -c eu h786poj.jpg
```

Questions
---------
Please post questions or comments to the Google group list: https://groups.google.com/forum/#!forum/openalpr


Contributions
-------------
Improvements to the OpenALPR library are always welcome.  Please review the [OpenALPR design description](https://github.com/openalpr/openalpr/wiki/OpenALPR-Design) and get started.

Code contributions are not the only way to help out.  Do you have a large library of license plate images?  If so, please upload your data to the anonymous FTP located at upload.openalpr.com.  Do you have time to "tag" plate images in an input image or help in other ways?  Please let everyone know by posting a note in the forum.


License
-------

Affero GPLv3
http://www.gnu.org/licenses/agpl-3.0.html

Commercial-friendly licensing available.  Contact: info@openalpr.com
