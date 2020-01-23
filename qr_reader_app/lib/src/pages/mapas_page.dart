import 'package:flutter/material.dart';
import 'package:qr_reader_app/src/bloc/scans_bloc.dart';
import 'package:qr_reader_app/src/providers/db_provider.dart';
import 'package:qr_reader_app/src/utils/utils.dart' as utils;

class MapasPage extends StatelessWidget {
  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    scansBloc.obtenerScans();

    return StreamBuilder<List<ScanModel>>(
      stream: scansBloc.scansStream,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator(),);
        } 
        final scans = snapshot.data;
        if (scans.length == 0) {
          return Center(child: Text('No hay info'),);
        }

        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (context, index) {
            return Dismissible(
              onDismissed: (DismissDirection direction) {
                scansBloc.borrarScan(scans[index].id);
              },
              key: UniqueKey(),
              background: Container(
                color: Colors.red,
              ),
              child: ListTile(
                leading: Icon(Icons.map, color: Theme.of(context).primaryColor,),
                title: Text(scans[index].valor),
                subtitle: Text('ID:' + scans[index].id.toString()),
                trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                onTap: () {
                  utils.abrirScan(context, scans[index]);
                },
              ),
            );
          }
        );
      },
    );
  }
}