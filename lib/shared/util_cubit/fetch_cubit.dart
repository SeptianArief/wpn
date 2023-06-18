import 'package:dashboard_wpn/app/auth/service/auth_service.dart';
import 'package:dashboard_wpn/app/karyawan/karyawan_service.dart';
import 'package:dashboard_wpn/app/kpi/kpi_service.dart';
import 'package:dashboard_wpn/app/pendapatan/pendapatan_service.dart';
import 'package:dashboard_wpn/app/pengeluaran/pengeluaran_service.dart';
import 'package:dashboard_wpn/app/production/production_service.dart';
import 'package:dashboard_wpn/shared/api_return_helper.dart';
import 'package:dashboard_wpn/shared/util_cubit/fetch_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchCubit extends Cubit<FetchState> {
  FetchCubit() : super(FetchInitial());

  fetchUser() async {
    emit(FetchLoading());
    AuthService.fetchUser().then((value) {
      if (value.status == RequestStatus.successRequest) {
        emit(ListUserLoaded(value.data!));
      } else {
        emit(FetchFailed(value));
      }
    });
  }

  fetchKaryawan() async {
    emit(FetchLoading());
    KaryawanService.fetchKaryawan().then((value) {
      if (value.status == RequestStatus.successRequest) {
        emit(ListKaryawanLoaded(value.data!));
      } else {
        emit(FetchFailed(value));
      }
    });
  }

  fetchProduction() async {
    emit(FetchLoading());
    ProductionService.fetchProduction().then((value) {
      if (value.status == RequestStatus.successRequest) {
        emit(ListProductionLoaded(value.data!));
      } else {
        emit(FetchFailed(value));
      }
    });
  }

  fetchPengeluaran() async {
    emit(FetchLoading());
    PengeluaranService.fetchPengeluaran().then((value) {
      if (value.status == RequestStatus.successRequest) {
        emit(ListPengeluaranLoaded(value.data!));
      } else {
        emit(FetchFailed(value));
      }
    });
  }

  fetchPenjualan() async {
    emit(FetchLoading());
    PendapatanService.fetchPendapatan().then((value) {
      if (value.status == RequestStatus.successRequest) {
        emit(ListPenjualanLoaded(value.data!));
      } else {
        emit(FetchFailed(value));
      }
    });
  }

  fetchKPI() async {
    emit(FetchLoading());
    KPIService.fetchKPI().then((value) {
      if (value.status == RequestStatus.successRequest) {
        emit(ListKPILoaded(value.data!));
      } else {
        emit(FetchFailed(value));
      }
    });
  }
}
