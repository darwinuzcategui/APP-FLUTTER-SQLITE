import 'package:flutter/material.dart';
import 'package:proyectomapasqssqlite/src/bloc/scans_bloc.dart';
import 'package:proyectomapasqssqlite/src/modelos/scan_model.dart';
import 'package:proyectomapasqssqlite/src/utils/scan_utils.dart' as utils;


class MapasPag extends StatelessWidget {
  
  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ScanModel>>(
      stream: scansBloc.scansStream,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final scans = snapshot.data;
        if (scans.length == 0) {
          return Center(
            child: Text('No Hay Informacion'),
          );
        }
        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (context, i) => Dismissible(
              key: UniqueKey(),
              background: Container(color: Colors.orange),
              //onDismissed: (direction)=>BaseDatoProvider.bd.eliminarScan(scans[i].id),
              onDismissed: (direction)=>scansBloc.borrarScan(scans[i].id),
              child: ListTile(
                leading: Icon(Icons.cloud_queue,
                    color: Theme.of(context).primaryColor),
                title: Text(scans[i].valor),
                subtitle: Text('ID: ${scans[i].id}'),
                trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                onTap:()=> utils.abrirScan(context,scans[i]),
              )
              ),
        );
      },
    );
  }
}
