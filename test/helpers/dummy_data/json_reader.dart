import 'dart:io';

String readJson(String name)
{
  var dir=Directory.current.path;
  if(dir.contains('/test')){
    dir=dir.replaceAll('/test', '');

  }
  return File('$dir/test/$name').readAsStringSync();
}