#!/bin/bash
gdbus call --session --dest com.example.FlutterApp \
--object-path /com/example/FlutterApp/Object \
--method com.example.FlutterApp.Open "['$1']" {}