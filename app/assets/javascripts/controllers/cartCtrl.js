app.controller("cartCtrl", function($scope, $http) {
  $scope.items = gon.items;
  $scope.subtotal = gon.subtotal;
  $scope.tax_rate = gon.tax_rate;
  $scope.total = gon.total;

  $scope.delete_item = function(item_id) {
    $http({
      url: 'cart/remove-cart/' + item_id + ".json",
      method: "DELETE"
    }).success(function(data) {
      $scope.items = data["items"];
      $scope.subtotal = data["subtotal"];
      $scope.tax_rate = data["tax_rate"];
      $scope.total = data["total"];
    }).error(function(data, status, headers, config){
       console.log("error with status", status, "headers", headers, "config", config)
    });
  };
});