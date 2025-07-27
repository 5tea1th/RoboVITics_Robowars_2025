import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 30),
            Center(
              child: Text(
                "My Profile",
                style: GoogleFonts.poppins(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 10),
            buildGradientDivider(height: 1),
            SizedBox(height: 2),
            buildGradientDivider(height: 1),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Text(
                  "<",
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple[900],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    Color(0xFF7532CC),
                  ],
                ),
              ),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(
                  Icons.person,
                  size: 110,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Name",
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Text(
              "Email ID",
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[400],
              ),
            ),
            SizedBox(height: 30),
            buildGradientDivider(height: 1.5),
            SizedBox(height: 30),
            buildOption("Team Name"),
            buildOption("Edit Profile"),
            buildOption("FAQs"),
            buildOption("Settings"),
            SizedBox(height: 40),

            Container(
              margin: EdgeInsets.symmetric(vertical: 30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF7532CC),Color(0xFF8764B5), Color(0xFF7532CC),Color(0xFFBA9BE2)],
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.all(2), // border thickness
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black, // inside fill color
                  borderRadius: BorderRadius.circular(28),
                ),
                child: InkWell(
                  onTap: () {
                    // Your logout logic here
                  },
                  borderRadius: BorderRadius.circular(14),
                  child: Padding(
                    padding: EdgeInsets.symmetric( horizontal:10,vertical: 12),
                    child: Center(
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),


            SizedBox(height: 30),
            buildGradientDivider(height: 1.5),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Text(
                "Made with 💜 by RoboVITics",
                style: GoogleFonts.poppins(
                  color: Colors.white54,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGradientDivider({double height = 1}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.transparent,
              Color (0xFFC45DFF),
              Colors.transparent,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget buildOption(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 70.0, top: 6.0, bottom: 6.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}