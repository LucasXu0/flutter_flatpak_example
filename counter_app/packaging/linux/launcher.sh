#!/bin/bash
gdbus call --session --dest com.example.FlutterApp \
--object-path /io/appflowy/AppflowyFlutter/Object \
--method io.appflowy.AppflowyFlutter "['$1']" {}