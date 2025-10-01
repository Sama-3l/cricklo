import os

# Structure
# Failures, UseCase -> boilerplate code
# Theme extensions & pubspec.yaml updates based on Fonts in "assets/<font-name>" folder

# Define only the substructure inside "lib"
structure = {
    "core": {
        "utils": {
            "common" : {},
            "constants" : {},
        },
        "usecase": {},
        "errors": {}
    },
    "features": {
        "home": {
            "data": {
                "entities" : {},
                "datasource" : {},
                "repo": {},
                "usecases": {},
            },
            "domain": {
                "entities": {},
                "models": {
                    "remote": {},
                    "local": {}
                }, 
                "repo": {}
            },
            "presentation": {
                "screens": {},
                "widgets": {},
                "blocs": {
                    "blocs": {},
                    "cubits": {}
                }
            }
        }
    },
    "routes": {}
}

failure_code = """abstract class Failure {
  final String? message;

  const Failure({this.message});

  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({String? message}) : super(message: message);
}

class CacheFailure extends Failure {
  const CacheFailure({String? message}) : super(message: message);
}

class LocalStorageFailure extends Failure {
  const LocalStorageFailure({String? message}) : super(message: message);
}

class InternetFailure extends Failure {
  const InternetFailure({String? message = 'No Internet Connection'})
    : super(message: message);
}

class ApiFailure extends Failure {
  const ApiFailure({String? message}) : super(message: message);

  @override
  List<Object?> get props => [message];

  @override
  String toString() => message ?? 'An error occurred.';
}

class FirebaseFailure extends Failure {
  const FirebaseFailure({String? message}) : super(message: message);
}

class DatabaseFailure extends Failure {}

class NormalFailure extends Failure {
  const NormalFailure({String? message}) : super(message: message);
}

class ValidationFailure extends Failure {
  const ValidationFailure({String? message}) : super(message: message);
}

class JsonSerializationFailure extends Failure {
  const JsonSerializationFailure({String? message}) : super(message: message);
}
"""
def create_folders(base_path, folder_dict):
    """Recursively create folders from a dictionary definition."""
    for folder, subfolders in folder_dict.items():
        new_path = os.path.join(base_path, folder)
        os.makedirs(new_path, exist_ok=True)
        if isinstance(subfolders, dict):
            create_folders(new_path, subfolders)

# Point directly to the existing "lib" folder
base_directory = os.path.join(os.getcwd(), "lib")
create_folders(base_directory, structure)

# Ensure core/failure exists
failure_dir = os.path.join(base_directory, "core", "errors")
os.makedirs(failure_dir, exist_ok=True)

# Write failure.dart
failure_path = os.path.join(failure_dir, "failure.dart")
if not os.path.exists(failure_path):
    with open(failure_path, "w", encoding="utf-8") as f:
        f.write(failure_code)

print("✅ Clean Architecture folder structure added inside 'lib' successfully!")
