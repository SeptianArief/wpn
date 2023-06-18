import 'package:dashboard_wpn/app/karyawan/karyawan_model.dart';
import 'package:dashboard_wpn/app/kpi/kpi_model.dart';
import 'package:dashboard_wpn/app/pendapatan/pendapatan_model.dart';
import 'package:dashboard_wpn/app/pengeluaran/pengeluaran_model.dart';
import 'package:dashboard_wpn/app/production/production_model.dart';
import 'package:dashboard_wpn/app/user/user_model.dart';
import 'package:dashboard_wpn/shared/api_return_helper.dart';
import 'package:equatable/equatable.dart';

abstract class FetchState extends Equatable {
  const FetchState();

  @override
  List<Object> get props => [];
}

class FetchInitial extends FetchState {}

class FetchLoading extends FetchState {}

class FetchFailed extends FetchState {
  final ApiReturnValue data;

  const FetchFailed(this.data);

  @override
  List<Object> get props => [data];
}

class ListUserLoaded extends FetchState {
  final List<UserModel> data;

  const ListUserLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class ListKaryawanLoaded extends FetchState {
  final List<KaryawanModel> data;

  const ListKaryawanLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class ListProductionLoaded extends FetchState {
  final List<Production> data;

  const ListProductionLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class ListPengeluaranLoaded extends FetchState {
  final List<Pengeluaran> data;

  const ListPengeluaranLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class ListPenjualanLoaded extends FetchState {
  final List<Penjualan> data;

  const ListPenjualanLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class ListKPILoaded extends FetchState {
  final List<KPI> data;

  const ListKPILoaded(this.data);

  @override
  List<Object> get props => [data];
}
