ifeq ($(origin JAVA_HOME), undefined)
  JAVA_HOME=/usr
endif

ifeq ($(origin NETLOGO), undefined)
  NETLOGO=../..
endif

JAVAC=$(JAVA_HOME)/bin/javac
SRCS=$(wildcard src/*.java)

pathdir.jar: $(SRCS) manifest.txt Makefile
        mkdir -p classes
        $(JAVAC) -g -deprecation -Xlint:all -Xlint:-serial -Xlint:-path -encoding us-ascii -source 1.5 -target 1.5 -classpath $(NETLOGO)/NetLogoLite.jar -d classes $(SRCS)
        jar cmf manifest.txt pathdir.jar -C classes .

pathdir.zip: pathdir.jar
        rm -rf pathdir
        mkdir pathdir
        cp -rp pathdir.jar README.md Makefile src manifest.txt pathdir
        zip -rv pathdir.zip pathdir
        rm -rf pathdir