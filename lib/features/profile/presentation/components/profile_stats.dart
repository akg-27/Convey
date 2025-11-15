/*

PROFILE STATS - This will be displayed on all the profile pages

--------------------------------------------------------------------------------
Displayed : 

 - posts
 - followers
 - following

*/

import 'package:flutter/material.dart';

class ProfileStats extends StatelessWidget {
  final int postCount;
  final int followerCount;
  final int followingCount;
  final void Function()? onTap;

  const ProfileStats({
    super.key,
    required this.postCount,
    required this.followerCount,
    required this.followingCount,
    required this.onTap,
  });

  // BUILD UI
  @override
  Widget build(BuildContext context) {
    // text style for count
    var textStyleforCount = TextStyle(
      fontSize: 20,
      color: Theme.of(context).colorScheme.inversePrimary,
    );

    // text style for Text
    var textStyleforText = TextStyle(
      color: Theme.of(context).colorScheme.inversePrimary,
    );
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Posts
          SizedBox(
            width: 100,
            child: Column(
              children: [
                Text(postCount.toString(), style: textStyleforCount),
                Text("Posts", style: textStyleforText),
              ],
            ),
          ),

          // Folowers
          SizedBox(
            width: 100,
            child: Column(
              children: [
                Text(followerCount.toString(), style: textStyleforCount),
                Text("Followers", style: textStyleforText),
              ],
            ),
          ),

          //Following
          SizedBox(
            width: 100,
            child: Column(
              children: [
                Text(followingCount.toString(), style: textStyleforCount),
                Text("Following", style: textStyleforText),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
