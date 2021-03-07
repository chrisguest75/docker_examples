function getDetails() {
  let vars = [];

  vars.push({key: "navigator.appVersion", value: navigator.appVersion});
  vars.push({key: "navigator.appName", value: navigator.appName});
  vars.push({key: "navigator.geolocation.getCurrentPosition", value: navigator.geolocation.getCurrentPosition});
  vars.push({key: "navigator.javaEnabled", value: navigator.javaEnabled()});
  vars.push({key: "navigator.platform", value: navigator.platform});
  vars.push({key: "navigator.product", value: navigator.product});
  vars.push({key: "navigator.productSub", value: navigator.productSub});
  vars.push({key: "navigator.appCodeName", value: navigator.appCodeName});


  vars.push({key: "window.devicePixelRatio", value: window.devicePixelRatio.toFixed(2)});
  vars.push({key: "window.screen.width", value: window.screen.width});
  vars.push({key: "window.screen.height", value: window.screen.height});

  const vw = Math.max(document.documentElement.clientWidth || 0, window.innerWidth || 0)
  const vh = Math.max(document.documentElement.clientHeight || 0, window.innerHeight || 0)
  vars.push({key: "viewport width", value: vw});
  vars.push({key: "viewport height", value: vh});


  return vars;
}





function loadTable() {
    $('#details_table').bootstrapTable({
        columns: [ {
          field: 'key',
          title: 'Key'
        }, {
          field: 'value',
          title: 'Value'
        }],
        data: getDetails() 
      })
}
