app.controller("cartCtrl", function($scope, $http) {
  $scope.items = gon.items;
  $scope.subtotal = gon.subtotal;
  $scope.tax_rate = gon.tax_rate;
  $scope.total = gon.total;

  $scope.get_data = function() {
    $http({
      url: 'cart/data.json',
      method: "GET"
    }).success(function(data) {
      $scope.items = data["items"];
//      $scope.subtotal = data["subtotal"];
      $scope.tax_rate = data["tax_rate"];
      $scope.total = data["total"];
    }).error(function(data, status, headers, config){
       console.log("error with status", status, "headers", headers, "config", config)
    });
  };
});