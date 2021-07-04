import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_tv_app/features/device/presentation/bloc/device_bloc.dart';
import 'package:focus_tv_app/injection_container.dart';

class ActivateDevicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ativar Dispositivo'),
      ),
      body: buildBody(),
    );
  }

  BlocProvider<DeviceBloc> buildBody() {
    return BlocProvider(
      create: (_) => sl<DeviceBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocBuilder<DeviceBloc, DeviceState>(
            builder: (context, state) {
              return ActivateDeviceForm();
            },
          ),
        ),
      ),
    );
  }
}

class ActivateDeviceForm extends StatefulWidget {
  @override
  _ActivateDeviceForm createState() => _ActivateDeviceForm();
}

class RequestFocusIntent extends Intent {
  RequestFocusIntent({required this.focusNode});
  final FocusNode focusNode;
}

class RequestFocusAction extends Action<RequestFocusIntent> {
  @override
  Object? invoke(RequestFocusIntent intent) {
    print('Requesting focus on');
    print(intent.focusNode);
    intent.focusNode.requestFocus();
  }
}

class _ActivateDeviceForm extends State<ActivateDeviceForm> {
  late FocusNode submitButtonNode;
  late FocusNode aliasFieldNode;

  @override
  void initState() {
    super.initState();
    submitButtonNode = FocusNode();
    aliasFieldNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    submitButtonNode.dispose();
    aliasFieldNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.arrowUp): RequestFocusIntent(
          focusNode: aliasFieldNode,
        ),
        LogicalKeySet(LogicalKeyboardKey.arrowDown): RequestFocusIntent(
          focusNode: submitButtonNode,
        ),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          RequestFocusIntent: RequestFocusAction(),
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Container(
                height: h / 5, // 20%
                child: Image(
                  image: AssetImage('assets/images/focus-produtora.png'),
                  fit: BoxFit.fill,
                  height: h / 5,
                ),
              ),
              SizedBox(height: 40),
              Container(
                padding: EdgeInsets.symmetric(horizontal: w / 4),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Informe o apelido desta TV',
                  ),
                  onSubmitted: (value) {
                    submitButtonNode.requestFocus();
                  },
                  focusNode: aliasFieldNode,
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  print('onSubmit');
                },
                child: Text('Ativar dispositivo'),
                focusNode: submitButtonNode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
