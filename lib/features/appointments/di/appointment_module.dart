import 'package:veterinaria/core/network/veterinaria_firebase.dart';
import 'package:veterinaria/features/appointments/data/datasources/repositories/appointment_repository_impl.dart';
import 'package:veterinaria/features/appointments/domain/repositories/appointment_repository.dart';
import 'package:veterinaria/features/appointments/domain/usecases/create_appointment_usecase.dart';

class AppointmentModule {
  late final AppointmentRepository appointmentRepository;
  late final CreateAppointmentUsecase createAppointmentUsecase;

  AppointmentModule({required VeterinariaFirebase firebase}) {
    _initDependencies(firebase);
  }

  void _initDependencies(VeterinariaFirebase firebase) {
    appointmentRepository = AppointmentRepositoryImpl(firestore: firebase.firestore);
    createAppointmentUsecase = CreateAppointmentUsecase(appointmentRepository);
  }
}
