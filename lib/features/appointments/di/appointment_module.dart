import 'package:veterinaria/core/network/veterinaria_firebase.dart';
import 'package:veterinaria/features/appointments/data/datasources/repositories/appointment_repository_impl.dart';
import 'package:veterinaria/features/appointments/domain/repositories/appointment_repository.dart';
import 'package:veterinaria/features/appointments/domain/usecases/create_appointment_usecase.dart';
import 'package:veterinaria/features/appointments/domain/usecases/get_appointments_by_user_id_usecase.dart';
import 'package:veterinaria/features/appointments/domain/usecases/update_appointment_usecase.dart';
import 'package:veterinaria/features/appointments/domain/usecases/delete_appointment_usecase.dart';

class AppointmentModule {
  late final AppointmentRepository appointmentRepository;
  late final CreateAppointmentUsecase createAppointmentUsecase;
  late final GetAppointmentsByUserIdUsecase getAppointmentsByUserIdUsecase;
  late final UpdateAppointmentUsecase updateAppointmentUsecase;
  late final DeleteAppointmentUsecase deleteAppointmentUsecase;

  AppointmentModule({required VeterinariaFirebase firebase}) {
    _initDependencies(firebase);
  }

  void _initDependencies(VeterinariaFirebase firebase) {
    appointmentRepository = AppointmentRepositoryImpl(firestore: firebase.firestore);
    createAppointmentUsecase = CreateAppointmentUsecase(appointmentRepository);
    getAppointmentsByUserIdUsecase = GetAppointmentsByUserIdUsecase(appointmentRepository);
    updateAppointmentUsecase = UpdateAppointmentUsecase(appointmentRepository);
    deleteAppointmentUsecase = DeleteAppointmentUsecase(appointmentRepository);
  }
}
