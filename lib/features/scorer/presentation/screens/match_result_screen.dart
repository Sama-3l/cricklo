import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:flutter/material.dart';

class MatchResultScreen extends StatefulWidget {
  final String teamLogo;
  final String teamName;
  final String resultMessage;

  const MatchResultScreen({
    super.key,
    required this.teamLogo,
    required this.teamName,
    required this.resultMessage,
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
                    backgroundColor: ColorsConstants.accentOrange.withValues(
                      alpha: 0.2,
                    ),
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
          ],
        ),
      ),
    );
  }
}
