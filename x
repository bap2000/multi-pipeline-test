#! /usr/bin/groovy

def gitHash = "git rev-parse HEAD".execute().text.trim()
println gitHash
