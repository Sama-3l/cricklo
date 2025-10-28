import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/scorer/domain/entities/match_center_entity.dart';
import 'package:flutter/material.dart';

class MatchResultScreen extends StatefulWidget {
  final String teamLogo;
  final String teamName;
  final String resultMessage;
  final MatchCenterEntity matchCenterEntity;

  const MatchResultScreen({
    super.key,
    required this.teamLogo,
    required this.teamName,
    required this.resultMessage,
    required this.matchCenterEntity,
  });

  @override
  State<MatchResultScreen> createState() => _MatchResultScreenState();
}

class _MatchResultScreenState extends State<MatchResultScreen> {
  bool error = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorsConstants.defaultWhite),
        backgroundColor: ColorsConstants.accentOrange,
        title: Text(
          "Match Result",
          style: TextStyles.poppinsMedium.copyWith(
            fontSize: 24,
            letterSpacing: -1.2,
            color: ColorsConstants.defaultWhite,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Team Logo
            error
                ? CircleAvatar(
                    radius: 60,
                    backgroundColor: ColorsConstants.surfaceOrange,
                    child: Icon(
                      Icons.people,
                      size: 32,
                      color: ColorsConstants.defaultBlack,
                    ),
                  )
                : CircleAvatar(
                    radius: 60,
                    backgroundImage: CachedNetworkImageProvider(
                      widget.teamLogo,
                      errorListener: (_) {
                        setState(() {
                          error = true;
                        });
                      },
                    ),
                  ),

            const SizedBox(height: 16),

            // Team Name
            Text(
              widget.teamName,
              style: TextStyles.poppinsSemiBold.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: -1.2,
              ),
            ),
            const SizedBox(height: 16),

            Text(
              widget.resultMessage,
              style: TextStyles.poppinsSemiBold.copyWith(
                fontSize: 16,
                letterSpacing: -0.8,
                color: ColorsConstants.accentOrange,
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         "Format",
            //         style: TextStyles.poppinsSemiBold.copyWith(
            //           fontSize: 12,
            //           letterSpacing: -0.5,
            //         ),
            //       ),
            //       const SizedBox(height: 8),
            //       DropdownButtonFormField<String>(
            //         dropdownColor: ColorsConstants.defaultWhite,
            //         initialValue: _selectedFormat,
            //         decoration: InputDecoration(
            //           labelText: _selectedFormat == null
            //               ? "Format of Game"
            //               : "",
            //           filled: true,
            //           labelStyle: TextStyles.poppinsMedium.copyWith(
            //             fontSize: 16,
            //             letterSpacing: -0.8,
            //             color: ColorsConstants.defaultBlack.withValues(
            //               alpha: 0.2,
            //             ),
            //           ),
            //           fillColor: ColorsConstants.onSurfaceGrey,
            //           border: OutlineInputBorder(borderSide: BorderSide.none),
            //         ),
            //         items: MatchType.values
            //             .map(
            //               (f) => DropdownMenuItem(
            //                 value: f.matchType,
            //                 child: Text(
            //                   f.matchType,
            //                   style: TextStyles.poppinsMedium.copyWith(
            //                     fontSize: 16,
            //                     letterSpacing: -0.8,
            //                   ),
            //                 ),
            //               ),
            //             )
            //             .toList(),
            //         onChanged: (val) {
            //           setState(() {
            //             _selectedFormat = val;
            //           });
            //         },
            //         validator: (val) =>
            //             val == null ? "Select a match format" : null,
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
