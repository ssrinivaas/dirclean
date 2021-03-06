#!/bin/bash 
# CLI recycle bin for individual directories
# Supply a file extension to recycle certain file types
# Ability to put back files, view recycle bin, and permanently delete
# Place bash script in the directory to clean up

DIR="$(basename "$PWD"_trash)"
mkdir -p $DIR 

undo(){
  echo "Put back what files?"
  read undo_file
  mv $DIR/*.$undo_file .
}

delete(){
  echo "Permanently delete all files or enter a file type"
  read delete_file
  if [ "$delete_file" == "all" ]; then
  	echo "Deleting:"
  	ls $DIR/
  	rm $DIR/*
  else
  	echo "Deleting:"
  	ls $DIR/*.$delete_file
  	rm $DIR/*.$delete_file
  fi   
}

peek(){
  echo "Files in recycle bin:"
  ls $DIR/
}

if [ "$#" -ne "0" ]; then 
  if [ "$1" == "undo" ]; then  
    undo
  elif [ "$1" == "delete" ]; then
    delete
  elif [ "$1" == "peek" ]; then
    peek
  else
    mv *.$* $DIR/ || echo "No such files found!"
  fi 

else 
  echo usage: `basename $0` "[file] [undo] [delete] [peek]" 1>&2
fi 


