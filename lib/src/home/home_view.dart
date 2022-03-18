import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:appwrite_authentication/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final superPowersProvider = FutureProvider<DocumentList>((ref) async {
  final client = ref.watch(appwriteClientProvider);
  final database = Database(client);
  return database.listDocuments(collectionId: '6225bfd5c9eb5d64c539');
});

class HomeViewArguments {
  const HomeViewArguments({required this.email});
  final String email;
}

class HomeView extends ConsumerWidget {
  const HomeView({Key? key, required this.email}) : super(key: key);
  static const String routeName = '/home';
  final String email;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 48,
            ),
            Text(
              'Welcome',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              email,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: 14,
            ),
            ref.watch(superPowersProvider).when(
                  data: (list) {
                    return Expanded(
                      child: Powers(list: list),
                    );
                  },
                  error: (e, s) => Text(e.toString()),
                  loading: () => const CircularProgressIndicator(),
                ),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('email', email));
  }
}

class Powers extends StatelessWidget {
  const Powers({
    Key? key,
    required this.list,
  }) : super(key: key);

  final DocumentList list;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.total,
      itemBuilder: (context, index) {
        final powers = list.convertTo((powers) => powers['power'] as String);
        return Text(
          powers[index],
          textAlign: TextAlign.center,
        );
      },
    );
  }
}
