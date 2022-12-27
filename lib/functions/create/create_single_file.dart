import 'dart:developer';
import 'dart:io';

import 'package:aveoauth/common/pubspec/pubspec_utils.dart';
import 'package:aveoauth/core/structure.dart';
import 'package:aveoauth/functions/file/import_sort.dart';
import 'package:aveoauth/samples/sample.dart';

File handleFileCreate(String name, String command, String on, bool extraFolder,
    Sample sample, String? folderName,
    [String sep = '_']) {
  folderName = folderName;
  /* if (folderName.isNotEmpty) {
    extraFolder = PubspecUtils.extraFolder ?? extraFolder;
  } */

  final fileModel = Structure.model(name, command, extraFolder,
      on: on, folderName: folderName);
  var path = '${fileModel.path}$sep${fileModel.commandName}.dart';
  sample.path = path;

  return sample.create();
}

/// Create or edit the contents of a file
File writeFile(String path, String content,
    {bool overwrite = false,
    bool skipFormatter = false,
    bool skipRename = false,
    bool useRelativeImport = false}) {
  var _file = File(Structure.replaceAsExpected(path: path));

  if (!_file.existsSync() || overwrite) {
    if (!skipFormatter) {
      if (path.endsWith('.dart')) {
        try {
          content = sortImports(
            content,
            renameImport: !skipRename,
            filePath: path,
            useRelative: useRelativeImport,
          );
        } on Exception catch (_) {
          if (_file.existsSync()) {
            log('file not found ${_file.path}');
          }
          rethrow;
        }
      }
    }
    if (!skipRename && _file.path != 'pubspec.yaml') {
      var separatorFileType = PubspecUtils.separatorFileType!;
      if (separatorFileType.isNotEmpty) {
        _file = _file.existsSync()
            ? _file = _file
                .renameSync(replacePathTypeSeparator(path, separatorFileType))
            : File(replacePathTypeSeparator(path, separatorFileType));
      }
    }

    _file.createSync(recursive: true);
    _file.writeAsStringSync(content);
  }
  return _file;
}

/// Replace the file name separator
String replacePathTypeSeparator(String path, String separator) {
  if (separator.isNotEmpty) {
    var index = path.indexOf(RegExp(
        r'login_loader.dart|login_social_login_button.dart|login_page.dart|login_otp.dart|login_snackbar.dart|login_verify_phone.dart|login_text_field.dart'));
    if (index != -1) {
      var chars = path.split('');
      index--;
      chars.removeAt(index);
      if (separator.length > 1) {
        chars.insert(index, separator[0]);
      } else {
        chars.insert(index, separator);
      }
      return chars.join();
    }
  }

  return path;
}
