// presentation/widgets/location_search_widget.dart
import 'package:cricklo/features/login/presentation/blocs/cubits/LocationCubit/location_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/location_entity.dart';

class LocationSearch extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  LocationSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(labelText: "Search Area"),
          onChanged: (query) {
            context.read<LocationCubit>().searchLocations(query);
          },
        ),
        BlocBuilder<LocationCubit, LocationState>(
          builder: (context, state) {
            if (state is LocationLoading) return CircularProgressIndicator();
            if (state is LocationLoaded) {
              return ListView(
                shrinkWrap: true,
                children: state.locations.map((LocationEntity loc) {
                  return ListTile(
                    title: Text("${loc.area}, ${loc.city}, ${loc.state}"),
                    subtitle: Text("Lat: ${loc.lat}, Lng: ${loc.lng}"),
                    onTap: () {
                      // handle selection
                    },
                  );
                }).toList(),
              );
            }
            if (state is LocationError) return Text(state.message);
            return Container();
          },
        ),
      ],
    );
  }
}
