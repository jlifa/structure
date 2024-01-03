import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';


///
/// * @Author：Marven
/// * @Description：
/// * @Data： 2022/4/21:6:23 下午
///

class FileUtils {
  static final String logReportFileName = 'im_flutter_report.log';

  static getPrintSize(limit) {
    String size = "";
    //内存转换
    if (limit < 0.1 * 1024) {
      //小于0.1KB，则转化成B
      size = limit.toString();
      size = "${size.substring(0, size.indexOf("."))}  B";
    } else if (limit < 0.1 * 1024 * 1024) {
      //小于0.1MB，则转化成KB
      size = (limit / 1024).toString();
      size = "${size.substring(0, size.indexOf("."))}  KB";
    } else if (limit < 0.1 * 1024 * 1024 * 1024) {
      //小于0.1GB，则转化成MB
      size = (limit / (1024 * 1024)).toString();
      print(size.indexOf("."));
      size = "${size.substring(0, size.indexOf("."))}  MB";
    } else {
      //其他转化成GB
      size = (limit / (1024 * 1024 * 1024)).toString();
      size = "${size.substring(0, size.indexOf(".") + 3)}  GB";
    }
    return size;
  }

  static String formatBytes(int bytes, [int decimals = 2]) {
    if (bytes <= 0) {
      return '0 B';
    }
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
    final i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }

  static String isMediaType(final String filePath) {
    final fileName = filePath.substring(filePath.lastIndexOf('/') + 1);
    final fileExt = fileName.substring(fileName.lastIndexOf('.'));
    switch (fileExt.toLowerCase()) {
      case '.jpg':
      case '.jpeg':
      case '.jpe':
      case '.png':
      case '.bmp':
      case '.gif':
        return 'image';

      case '.pdf':
      case '.svg':
        return 'file';
      default:
        return '';
    }
  }

  static Future<String> filePath() async {
    Directory path = await getApplicationDocumentsDirectory();
    return '${path.path}${Platform.pathSeparator}file/';
  }

  static Future<bool> isExistDir() async {
    Directory path = await getApplicationDocumentsDirectory();
    String localPath = '${path.path}${Platform.pathSeparator}file';
    final saveDir = Directory(localPath);
    bool hasExisted = await saveDir.exists();
    return hasExisted;
  }

  static Future<bool> isExistFile(String fileName,
      {bool isDelete = false}) async {
    Directory path = await getApplicationDocumentsDirectory();
    String localPath =
        '${path.path}${Platform.pathSeparator}file${Platform.pathSeparator}';
    final saveDir = Directory(localPath);
    bool hasExisted = await saveDir.exists();
    if (!hasExisted) {
      saveDir.create();
      return false;
    }
    String filePath = localPath + fileName;
    File file = File(filePath);
    var isExist = await file.exists();
    if (isExist) {
      if (isDelete) {
        file.delete();
      }
      return true;
    } else {
      return false;
    }
  }

  static Future<String> getExistFilePath(String fileName) async {
    Directory path = await getApplicationDocumentsDirectory();
    String localPath =
        '${path.path}${Platform.pathSeparator}file${Platform.pathSeparator}';
    final saveDir = Directory(localPath);
    bool hasExisted = await saveDir.exists();
    if (!hasExisted) {
      saveDir.create();
      return "";
    }
    String filePath = localPath + fileName;
    File file = File(filePath);
    var isExist = await file.exists();
    if (isExist) {
      return filePath;
    } else {
      return "";
    }
  }

  ///拷贝沙盒下的文件到指定目录
  static Future<String?> copyExistsFileToDir(
      String fileName, String disDir) async {
    bool isExists = await isExistFile(fileName);
    if (isExists) {
      Directory path = await getApplicationDocumentsDirectory();
      String localPath =
          '${path.path}${Platform.pathSeparator}file${Platform.pathSeparator}';
      String filePath = localPath + fileName;
      File file = File(filePath);
      return file.copySync('$disDir${Platform.pathSeparator}$fileName').path;
    }
    return null;
  }

  static Future<bool> isExistFileWithPath(String path) async {
    List<String> fileArray = path.split('/');
    String fileName = fileArray[fileArray.length - 1];
    Directory dPath = await getApplicationDocumentsDirectory();
    String localPath =
        '${dPath.path}${Platform.pathSeparator}file${Platform.pathSeparator}';
    final saveDir = Directory(localPath);
    bool hasExisted = await saveDir.exists();
    if (!hasExisted) {
      saveDir.create();
      return false;
    }
    String filePath = localPath + fileName;
    File file = File(filePath);
    var isExist = await file.exists();
    if (isExist) {
      return true;
    } else {
      return false;
    }
  }

  static String getFilename({required String path}) {
    List<String> fileArray = path.split('/');
    String fileName = fileArray[fileArray.length - 1];
    return fileName;
  }

  static int getFileSize({required String path}) {
    var file = File(path);
    int sizeInBytes = file.lengthSync();
    int sizeInMb = (sizeInBytes / (1024 * 1024)) as int;
    return sizeInMb;
  }

  /// 临时目录
  /// 获取一个临时目录(缓存)，系统可以随时清除。
  static Future<String?> getTempDir() async {
    try {
      Directory tempDir = await getTemporaryDirectory();
      return tempDir.path;
    } catch (err) {
     // LogUtil.e(err);
      return null;
    }
  }

  ///fileFullPath-把图片数据写入到临时文件 fileFullPath-指定了路径把图片数据写入指定文件
  static Future<File?>? writeImageUnit8ListData(Uint8List? bytes,
      {String? fileFullPath}) async {
    if (bytes == null) {
      return null;
    }
    String? tempDir = await getTempDir();
    if (tempDir == null) return null;
    String imageName = 'im-image-${DateTime.now().millisecondsSinceEpoch}.png';
    try {
      if (fileFullPath == null || fileFullPath.isEmpty) {
        fileFullPath =
        "$tempDir${Platform.pathSeparator}im_temp_images${Platform.pathSeparator}$imageName";
        await FileUtils.writeToLogFile("---writeImageUnit8ListData:fileFullPath:$fileFullPath");
        final pathOfImage = await File(fileFullPath).create(recursive: true);
        await pathOfImage.writeAsBytes(bytes);
        return pathOfImage;
      }
    } catch (e) {
   //   LogUtil.e(e);
    }
    return null;
  }

  ///windows 生成未读ico图片
  static Future<File?>? writeWindowsIcoUnit8ListData(List<int> data,
      {String? fileFullPath}) async {
    if (data.isEmpty) {
      return null;
    }
    String? tempDir = await getTempDir();
    if (tempDir == null) return null;
    String imageName = 'unread_msg.ico';
    try {
      if (fileFullPath == null || fileFullPath.isEmpty) {
        fileFullPath =
        "$tempDir${Platform.pathSeparator}unread${Platform.pathSeparator}$imageName";
       // LogUtil.d("---writeImageUnit8ListData:fileFullPath:$fileFullPath");
        final File pathOfImage =
        await File(fileFullPath).create(recursive: true);
        pathOfImage.writeAsBytesSync(data);
        return pathOfImage;
      }
    } catch (e) {
    //  LogUtil.e(e);
    }
    return null;
  }

  /// 文档目录
  /// 获取应用程序的目录，用于存储只有它可以访问的文件。只有当应用程序被删除时，系统才会清除目录。
  static Future<String?> getAppDocDir() async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      return appDocDir.path;
    } catch (err) {
     // LogUtil.e(err);
      return null;
    }
  }

  ///Read File
  static File readFile(filePath) {
    return File('$filePath');
  }

  /// 写入json文件，自定义路径
  static Future<File?> writeJsonCustomFile(Object obj, String filePath) async {
    try {
      final file = readFile(filePath);
      return await file.writeAsString(json.encode(obj));
    } catch (err) {
     // LogUtil.e(err);
      return null;
    }
  }

  ///利用文件存储字符串，自定义路径
  static Future<File?> writeStringFile(String string, String filePath) async {
    try {
      final file = readFile(filePath);
      return await file.writeAsString(string);
    } catch (err) {
     // LogUtil.e(err);
      return null;
    }
  }

  ///获取自定义路径文件存中的数据
  ///使用async、await，返回是一个Future对象
  static Future<String?> readStringCustomFile(String filePath) async {
    try {
      final file = readFile(filePath);
      return await file.readAsString();
    } catch (err) {
     // LogUtil.e(err);
      return null;
    }
  }

  ///清除缓存数据
  static Future<bool> clearFileData(String filePath) async {
    try {
      final file = readFile(filePath);
      file.writeAsStringSync("");
      return true;
    } catch (err) {
     // LogUtil.e(err);
      return false;
    }
  }

  ///删除缓存文件
  static Future<bool> deleteFileData(String filePath) async {
    try {
      final file = readFile(filePath);
      file.delete();
      return true;
    } catch (err) {
   //   LogUtil.e(err);
      return false;
    }
  }

  ///日志上报文件
  static Future<File?> getAppLogFile(String fileName) async {
    //获取存储路径
    final filePath = await getAppDocDir();
    if (filePath == null) {
      return null;
    }
    //或者file对象（操作文件记得导入import 'dart:io'）
    String dirPath =
        "$filePath${Platform.pathSeparator}report${Platform.pathSeparator}";
    var saveDir = Directory(dirPath);
    bool hasExisted = await saveDir.exists();
    if (!hasExisted) {
      saveDir.create();
    }
    File realFile = File("$dirPath$fileName");
    if (!realFile.existsSync()) {
      realFile = await realFile.create();
      //var deviceInfo = await ReportUtil().getDeviceInfo();
     // LogUtil.d("deviceInfo \n ${deviceInfo.toString()}");
     //  realFile.writeAsStringSync("deviceInfo:${deviceInfo.toString()}\n",
     //      flush: true);
    }
    return realFile;
  }

  ///获取日志存文件
  static Future<String?> getAppLogFilePath() async {
    //获取存储路径
    final filePath = await getAppDocDir();
    if (filePath == null) {
      return null;
    }
    return "$filePath${Platform.pathSeparator}report${Platform.pathSeparator}$logReportFileName";
  }

  ///app初始化的时候 进行日志上报文件初始化
  static Future<void> initLogFileReport() async {
    // try {
    //   File? file = await getAppLogFile(logReportFileName);
    //   if(file == null) {
    //     return;
    //   }
    //   var deviceInfo = await ReportUtil().getDeviceInfo();
    //   if(!file.existsSync()) {
    //     file.create();
    //     LogUtil.d("deviceInfo \n ${deviceInfo.toString()}");
    //     file.writeAsStringSync(deviceInfo.toString(), flush: true);
    //   }
    //   //App启动的时候 判断最后修改时间 >24h 清空文件
    //   DateTime now = DateTime.now();
    //   int? logFileLastAccessTime = SpUtil.getInt(SpKey.logFileLastAccessTime, defValue: 0);
    //   DateTime lastModifyTime = DateTime.fromMillisecondsSinceEpoch(logFileLastAccessTime!);
    //   if(logFileLastAccessTime == 0 || now.millisecondsSinceEpoch - lastModifyTime.millisecondsSinceEpoch > 24 * 3600000) {
    //     SpUtil.putInt(SpKey.logFileLastAccessTime, now.millisecondsSinceEpoch);
    //     file.writeAsStringSync("", flush: true);
    //     file.writeAsStringSync(deviceInfo.toString(),flush: true);
    //     LogUtil.d("--------------reset log content------------");
    //   }
    //   await file.writeAsString("2023-7-20-version", mode: FileMode.append, flush: true);
    // } catch (err) {
    //   LogUtil.e(err);
    // }
  }

  ///手动清理日志文件 只能在上报成功后调用
  // static Future<void> clearReportLogFile() async {
  //   await SembastManager.instance.deleteLog();
  //   // try {
  //   //   File? file = await getAppLogFile(logReportFileName);
  //   //   if (file == null) {
  //   //     return;
  //   //   }
  //   //   var deviceInfo = await ReportUtil().getDeviceInfo();
  //   //   if (!file.existsSync()) {
  //   //     file.create();
  //   //     LogUtil.d("deviceInfo \n ${deviceInfo.toString()}");
  //   //     file.writeAsStringSync(deviceInfo.toString(), flush: true);
  //   //   }
  //   //   file.writeAsStringSync("", flush: true);
  //   //   file.writeAsStringSync(deviceInfo.toString(), flush: true);
  //   //   LogUtil.d("--------------reset log content------------");
  //   // } catch (err) {
  //   //   LogUtil.e(err);
  //   // }
  // }

  ///往日志文件以追加方式写入数据
  static Future<void> writeToLogFile(String contents) async {
    if (contents.contains("PCLive") ||
        contents.contains("mobileCheckPCLive") ||
        contents.contains("input_status") ||
        contents.contains("read")) {
      //状态消息不再存储
      return;
    }
   // LogUtil.d(contents);

  //  await SembastManager.instance.addLog(contents);

    // try {
    //   File? file = await getAppLogFile(logReportFileName);
    //   if(file == null) {
    //     return;
    //   }
    //   if(!file.existsSync()) {
    //     file.create();
    //   }
    //   String timeStamp = DateUtil.formatDateMs(DateTime.now().millisecondsSinceEpoch, format: DateFormats.full_mill);
    //   contents = "$timeStamp\t $contents";
    //   await file.writeAsString(contents, mode: FileMode.append, flush: true);
    //   return;
    // } catch (err) {
    //   LogUtil.e(err);
    // }
    return;
  }

  static Future<void> saveErrorLog(Object error, StackTrace stackTrace) async {
    String content =
        "handleUncaughtError:$error \n handleUncaughtStackTrace:$stackTrace \n";
    await FileUtils.writeToLogFile(content);
  }

  static Future<void> saveErrorIMLog(
      Object error, StackTrace stackTrace) async {
    String content = "IMLogError:$error \n IMLogStackTrace:$stackTrace \n";
    await FileUtils.writeToLogFile(content);
  }

  static Future<void> saveOnErrorDetailLog(
      FlutterErrorDetails errorDetail) async {
    String content = "IMErrorDetail:$errorDetail \n";
    await FileUtils.writeToLogFile(content);
  }

}
