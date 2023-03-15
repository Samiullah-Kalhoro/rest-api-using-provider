import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../providers/auth_provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final currentUser = authProvider.currentUser;
    return Column(
      children: [
        const SizedBox(height: 20),
        ProfileRow(
          title: 'Name',
          value: currentUser?.name ?? '',
        ),
        const Divider(),
        ProfileRow(title: 'Username', value: currentUser?.username ?? ''),
        const Divider(),
        ProfileRow(
            title: 'Address',
            value:
                ('${currentUser?.address.street}, ${currentUser?.address.suite},\n${currentUser?.address.city}')),
        const Divider(),
        ProfileRow(title: 'Zipcode', value: currentUser?.address.zipcode ?? ''),
      ],
    );
  }
}

class ProfileRow extends StatelessWidget {
  const ProfileRow({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 20),
            softWrap: true,
            textAlign: TextAlign.end,
          ),
        ],
      ),
    );
  }
}
