import 'package:flutter/widgets.dart';
import 'package:mobile_app/src/core/utils/extensions/context_x.dart';

import 'failure.dart';

extension FailureX on Failure{
  String defaultMessage(BuildContext context){
    if(runtimeType.toString() == 'ApiFailure'){
      return context.l10n.apiFailureDefaultMessage;
    }else if(runtimeType.toString() == 'ParseFailure'){
      return context.l10n.parseFailureDefaultMessage;
    }else{
      return context.l10n.baseDefaultMessage;
    }
  }
}