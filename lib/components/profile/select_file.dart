import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const Color _green = Color(0xff296e48);

class SelectFileButton extends StatelessWidget {
  const SelectFileButton({
    super.key,
    //required this.onFileSelected,
  });

  //final Function(List<XFile> media) onFileSelected;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      strokeWidth: 3,
      dashPattern: const [6, 6],
      strokeCap: StrokeCap.round,
      borderType: BorderType.RRect,
      radius: const Radius.circular(10),
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color: _green,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.folder_open_rounded,
                size: 32,
              ),
              const SizedBox(width: 16),
              Text(
                  AppLocalizations.of(context)!.select_file,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(),
              )
            ],
          ),
        ),
      ),
    );
  }

  // void pickMedia(BuildContext context) async {
  //   showLoadingDialog(context);
  //
  //   final picker = ImagePicker();
  //   try {
  //     final media = await picker.pickMultipleMedia();
  //     onFileSelected(media);
  //   } catch (e) {
  //     showInfoSnackBar(context, "Some media/files cannot be selected !");
  //   } finally {
  //     // close loading dialog
  //     Navigator.pop(context);
  //   }
  // }
}