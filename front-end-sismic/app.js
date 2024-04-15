angular.module('myApp', ['myApp.header']).controller('MainController', function ($scope, $http) {

        $scope.userPerPage = 10;
        // Función para obtener características por mag_type
        $scope.getFeaturesByMagType = function (magType) {
            if(magType != ''){
               
                var endpoint = 'http://localhost:3000/api/features?page=' + + $scope.currentPage + '&per_page=' + $scope.userPerPage + '&mag_type[]=' + magType;
                $http.get(endpoint)
                    .then(function (response) {
                        $scope.allFeatures = response.data.data;
                        $scope.allFeatures = response.data.data;
                        $scope.currentPage = response.data.pagination.current_page;
                        $scope.totalPages = Math.ceil(response.data.pagination.total / $scope.userPerPage);
                       
                    })
                    .catch(function (error) {
                        console.error('Error fetching features by mag_type:', error);
                    });
            }else{
                $scope.getAllFeatures();
            }
        };

        $scope.updatePerPageBy = function (userPer, magType) {
            $scope.userPerPage = userPer;
            $scope.getFeaturesByMagType(magType)
        }


        // Función para obtener todas las características paginadas



        $scope.currentPage = 1;
        $scope.totalPages = 1;



        $scope.getAllFeatures = function () {
            var endpoint = 'http://localhost:3000/api/features?page=' + $scope.currentPage + '&per_page=' + $scope.userPerPage;
            $http.get(endpoint)
                .then(function (response) {
                    $scope.allFeatures = response.data.data;
                    $scope.currentPage = response.data.pagination.current_page;
                    $scope.totalPages = Math.ceil(response.data.pagination.total / $scope.userPerPage);
                })
                .catch(function (error) {
                    console.error('Error fetching all features:', error);
                });
        };

        $scope.getFeaturesPage = function (page) {
            if (page < 1 || page > $scope.totalPages) {
                return;
            }
            $scope.currentPage = page;
            if ($scope.magType) {
                $scope.getFeaturesByMagType($scope.magType);
            } else {
                $scope.getAllFeatures();
            }
        };

        $scope.resetPagination = function () {
            $scope.currentPage = 1;
            $scope.totalPages = 1;
        };


        $scope.updatePerPage = function(userPer) {
            $scope.userPerPage = userPer;
            if ($scope.magType) {
                $scope.getFeaturesByMagType($scope.magType);
            } else {
                $scope.getAllFeatures();
            }
        };
        



        // Función para crear un comentario
        $scope.createComment = function (featureId, commentBody) {
            var commentData = { body: commentBody };
            var endpoint = 'http://localhost:3000/api/features/' + featureId + '/comments';

            $http.post(endpoint, commentData)
                .then(function (response) {
                    $scope.commentCreated = response.data; // Asigna el comentario creado a la variable
                    Swal.fire({
                        icon: 'success',
                        title: 'Comentario creado exitosamente',
                        showConfirmButton: false,
                        timer: 1500
                    });
                    // Limpiar el formulario
                    $scope.featureId = '';
                    $scope.commentBody = '';
                })
                .catch(function (error) {
                    // Mostrar mensaje de error
                    Swal.fire({
                        icon: 'error',
                        title: 'Error al crear el comentario',
                        text: 'Ha ocurrido un error al intentar crear el comentario.',
                        confirmButtonText: 'Cerrar'
                    });
                });
        };
    });