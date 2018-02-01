"use strict";

var app_demo = {
  solutions: {
    bank: {
      change_password: function() {
        $("#show_password").change(function() {
          $(this).is(":checked") ? $("#old_password, #rep_password, #new_password").attr("type", "text") : $("#old_password, #rep_password, #new_password").attr("type", "password")
        })
      },
      change_pin: function() {
        $("#modal-change-pin").on("shown.bs.modal", function() {
          $("input.mask_pin").mask("99-99"), $("input.mask_pin").focus()
        })
      }
    }
  },
  googlemap: function() {
    if ($("#google_world_map").length > 0) {
      var a = new google.maps.LatLng(0, 0),
        e = {
          zoom: 1,
          center: a,
          mapTypeId: google.maps.MapTypeId.ROADMAP
        };
      new google.maps.Map(document.getElementById("google_world_map"), e)
    }
    if ($("#google_map_markers").length > 0) {
      var t = new google.maps.LatLng(50.43, 30.6),
        i = {
          zoom: 8,
          center: t,
          mapTypeId: google.maps.MapTypeId.ROADMAP
        },
        n = new google.maps.Map(document.getElementById("google_map_markers"), i),
        o = new google.maps.LatLng(50.37, 30.65),
        o = (new google.maps.Marker({
          position: o,
          map: n,
          title: "Marker 1"
        }), new google.maps.LatLng(50.5, 30.55)),
        o = (new google.maps.Marker({
          position: o,
          map: n,
          title: "Marker 2"
        }), new google.maps.LatLng(50.8, 30.55));
      new google.maps.Marker({
        position: o,
        map: n,
        title: "Marker 3"
      })
    }
    if ($("#google_map_style").length > 0) {
      var r = [{
          featureType: "landscape",
          stylers: [{
            saturation: -100
          }, {
            lightness: 65
          }, {
            visibility: "on"
          }]
        }, {
          featureType: "poi",
          stylers: [{
            saturation: -100
          }, {
            lightness: 51
          }, {
            visibility: "simplified"
          }]
        }, {
          featureType: "road.highway",
          stylers: [{
            saturation: -100
          }, {
            visibility: "simplified"
          }]
        }, {
          featureType: "road.arterial",
          stylers: [{
            saturation: -100
          }, {
            lightness: 30
          }, {
            visibility: "on"
          }]
        }, {
          featureType: "road.local",
          stylers: [{
            saturation: -100
          }, {
            lightness: 40
          }, {
            visibility: "on"
          }]
        }, {
          featureType: "transit",
          stylers: [{
            saturation: -100
          }, {
            visibility: "simplified"
          }]
        }, {
          featureType: "administrative.province",
          stylers: [{
            visibility: "off"
          }]
        }, {
          featureType: "water",
          elementType: "labels",
          stylers: [{
            visibility: "on"
          }, {
            lightness: -25
          }, {
            saturation: -100
          }]
        }, {
          featureType: "water",
          elementType: "geometry",
          stylers: [{
            hue: "#ffff00"
          }, {
            lightness: -25
          }, {
            saturation: -97
          }]
        }],
        s = new google.maps.LatLng(50.43, 30.6),
        l = {
          styles: r,
          zoom: 8,
          center: s,
          mapTypeId: google.maps.MapTypeId.ROADMAP
        };
      new google.maps.Map(document.getElementById("google_map_style"), l)
    }
  },
  jvectormap: function() {
    $("#jvm-world-map").length > 0 && $("#jvm-world-map").vectorMap({
      map: "world_mill_en",
      backgroundColor: "#F5F5F5",
      regionsSelectable: !0,
      regionStyle: {
        selected: {
          fill: "#4FB5DD"
        },
        initial: {
          fill: "#2D3349"
        }
      }
    }), $("#jvm-us_map").length > 0 && $("#jvm-us_map").vectorMap({
      map: "us_aea_en",
      backgroundColor: "#F5F5F5",
      regionsSelectable: !0,
      regionStyle: {
        selected: {
          fill: "#4FB5DD"
        },
        initial: {
          fill: "#2D3349"
        }
      }
    }), $("#jvm-world-map-markers").length > 0 && $("#jvm-world-map-markers").vectorMap({
      map: "world_mill_en",
      backgroundColor: "#F5F5F5",
      normalizeFunction: "polynomial",
      regionStyle: {
        selected: {
          fill: "#4FB5DD"
        },
        initial: {
          fill: "#2D3349"
        }
      },
      markerStyle: {
        initial: {
          fill: "#4FB5DD",
          stroke: "#2D3349"
        }
      },
      markers: [{
        latLng: [41.9, 12.45],
        name: "Vatican City"
      }, {
        latLng: [43.73, 7.41],
        name: "Monaco"
      }, {
        latLng: [-.52, 166.93],
        name: "Nauru"
      }, {
        latLng: [-8.51, 179.21],
        name: "Tuvalu"
      }, {
        latLng: [43.93, 12.46],
        name: "San Marino"
      }, {
        latLng: [47.14, 9.52],
        name: "Liechtenstein"
      }, {
        latLng: [7.11, 171.06],
        name: "Marshall Islands"
      }, {
        latLng: [17.3, -62.73],
        name: "Saint Kitts and Nevis"
      }, {
        latLng: [3.2, 73.22],
        name: "Maldives"
      }, {
        latLng: [35.88, 14.5],
        name: "Malta"
      }, {
        latLng: [12.05, -61.75],
        name: "Grenada"
      }, {
        latLng: [13.16, -61.23],
        name: "Saint Vincent and the Grenadines"
      }, {
        latLng: [13.16, -59.55],
        name: "Barbados"
      }, {
        latLng: [17.11, -61.85],
        name: "Antigua and Barbuda"
      }, {
        latLng: [-4.61, 55.45],
        name: "Seychelles"
      }, {
        latLng: [7.35, 134.46],
        name: "Palau"
      }, {
        latLng: [42.5, 1.51],
        name: "Andorra"
      }, {
        latLng: [14.01, -60.98],
        name: "Saint Lucia"
      }, {
        latLng: [6.91, 158.18],
        name: "Federated States of Micronesia"
      }, {
        latLng: [1.3, 103.8],
        name: "Singapore"
      }, {
        latLng: [1.46, 173.03],
        name: "Kiribati"
      }, {
        latLng: [-21.13, -175.2],
        name: "Tonga"
      }, {
        latLng: [15.3, -61.38],
        name: "Dominica"
      }, {
        latLng: [-20.2, 57.5],
        name: "Mauritius"
      }, {
        latLng: [26.02, 50.55],
        name: "Bahrain"
      }, {
        latLng: [.33, 6.73],
        name: "SÃ£o TomÃ© and PrÃ­ncipe"
      }]
    }), $("#jvm-us-map-labels").length > 0 && $("#jvm-us-map-labels").vectorMap({
      map: "us_aea_en",
      backgroundColor: "#F5F5F5",
      regionStyle: {
        selected: {
          fill: "#4FB5DD"
        },
        initial: {
          fill: "#2D3349"
        }
      },
      regionLabelStyle: {
        initial: {
          fill: "#FFF"
        },
        hover: {
          fill: "#4FB5DD"
        }
      },
      labels: {
        regions: {
          render: function(a) {
            var e = ["US-RI", "US-DC", "US-DE", "US-MD"];
            return -1 === e.indexOf(a) ? a.split("-")[1] : void 0
          },
          offsets: function(a) {
            return {
              CA: [-10, 10],
              ID: [0, 40],
              OK: [25, 0],
              LA: [-20, 0],
              FL: [45, 0],
              KY: [10, 5],
              VA: [15, 5],
              MI: [30, 30],
              AK: [50, -25],
              HI: [25, 50]
            }[a.split("-")[1]]
          }
        }
      }
    })
  },
  charts: {
    morris: function() {
      $("#morris-line-example").length > 0 && (Morris.Line({
        element: "morris-line-example",
        data: [{
          y: "2006",
          a: 100,
          b: 90
        }, {
          y: "2007",
          a: 75,
          b: 65
        }, {
          y: "2008",
          a: 50,
          b: 40
        }, {
          y: "2009",
          a: 75,
          b: 65
        }, {
          y: "2010",
          a: 50,
          b: 40
        }, {
          y: "2011",
          a: 75,
          b: 65
        }, {
          y: "2012",
          a: 100,
          b: 90
        }],
        xkey: "y",
        ykeys: ["a", "b"],
        labels: ["Series A", "Series B"],
        resize: !0,
        lineColors: ["#2D3349", "#76AB3C"]
      }), Morris.Area({
        element: "morris-area-example",
        data: [{
          y: "2006",
          a: 100,
          b: 90
        }, {
          y: "2007",
          a: 75,
          b: 65
        }, {
          y: "2008",
          a: 50,
          b: 40
        }, {
          y: "2009",
          a: 75,
          b: 65
        }, {
          y: "2010",
          a: 50,
          b: 40
        }, {
          y: "2011",
          a: 75,
          b: 65
        }, {
          y: "2012",
          a: 100,
          b: 90
        }],
        xkey: "y",
        ykeys: ["a", "b"],
        labels: ["Series A", "Series B"],
        resize: !0,
        lineColors: ["#4FB5DD", "#F69F00"]
      }), Morris.Bar({
        element: "morris-bar-example",
        data: [{
          y: "2006",
          a: 100,
          b: 90
        }, {
          y: "2007",
          a: 75,
          b: 65
        }, {
          y: "2008",
          a: 50,
          b: 40
        }, {
          y: "2009",
          a: 75,
          b: 65
        }, {
          y: "2010",
          a: 50,
          b: 40
        }, {
          y: "2011",
          a: 75,
          b: 65
        }, {
          y: "2012",
          a: 100,
          b: 90
        }],
        xkey: "y",
        ykeys: ["a", "b"],
        labels: ["Series A", "Series B"],
        barColors: ["#2D3349", "#F04E51"]
      }), Morris.Donut({
        element: "morris-donut-example",
        data: [{
          label: "Download Sales",
          value: 12
        }, {
          label: "In-Store Sales",
          value: 30
        }, {
          label: "Mail-Order Sales",
          value: 20
        }],
        colors: ["#2D3349", "#4FB5DD", "#F04E51"]
      }))
    },
    rickshaw: function() {
      if ($("#charts-lineplot").length > 0) {
        for (var a = [], e = [], t = [], i = 0; 10 > i; i += .3) a.push({
          x: i,
          y: Math.sin(i)
        }), t.push({
          x: i,
          y: Math.sin(i - 1.57)
        }), e.push({
          x: i,
          y: Math.cos(i)
        }); {
          var n = new Rickshaw.Graph({
            element: document.getElementById("charts-lineplot"),
            renderer: "lineplot",
            min: -1.2,
            max: 1.2,
            padding: {
              top: .1
            },
            series: [{
              data: a,
              color: "#2D3349",
              name: "sin"
            }, {
              data: t,
              color: "#76AB3C",
              name: "sin2"
            }, {
              data: e,
              color: "#4FB5DD",
              name: "cos"
            }]
          });
          new Rickshaw.Graph.HoverDetail({
            graph: n
          })
        }
        n.render();
        var o = function() {
          n.configure({
            width: $("#charts-lineplot").width(),
            height: $("#charts-lineplot").height()
          }), n.render()
        };
        window.addEventListener("resize", o), o();
        for (var r = [
            [],
            [],
            []
          ], s = new Rickshaw.Fixtures.RandomData(50), i = 0; 50 > i; i++) s.addData(r);
        var l = new Rickshaw.Graph({
          element: document.getElementById("charts-lines"),
          renderer: "line",
          min: 50,
          series: [{
            color: "#76AB3C",
            data: r[0],
            name: "New York"
          }, {
            color: "#4FB5DD",
            data: r[1],
            name: "London"
          }, {
            color: "#F04E51",
            data: r[2],
            name: "Tokyo"
          }]
        });
        l.render();
        var p = (new Rickshaw.Graph.HoverDetail({
          graph: l
        }), new Rickshaw.Graph.Axis.Time({
          graph: l
        }));
        p.render();
        var d = function() {
          l.configure({
            width: $("#charts-lines").width(),
            height: $("#charts-lines").height()
          }), l.render()
        };
        window.addEventListener("resize", d), d();
        var c = new Rickshaw.Graph({
          unstack: !0,
          element: document.querySelector("#charts-column"),
          min: 30,
          renderer: "bar",
          series: [{
            color: "#2D3349",
            data: [{
              x: 0,
              y: 50
            }, {
              x: 1,
              y: 52
            }, {
              x: 2,
              y: 36
            }, {
              x: 3,
              y: 42
            }, {
              x: 4,
              y: 36
            }, {
              x: 5,
              y: 50
            }]
          }, {
            color: "#4FB5DD",
            data: [{
              x: 0,
              y: 48
            }, {
              x: 1,
              y: 40
            }, {
              x: 2,
              y: 45
            }, {
              x: 3,
              y: 32
            }, {
              x: 4,
              y: 33
            }, {
              x: 5,
              y: 45
            }]
          }, {
            color: "#F04E51",
            data: [{
              x: 0,
              y: 43
            }, {
              x: 1,
              y: 35
            }, {
              x: 2,
              y: 46
            }, {
              x: 3,
              y: 49
            }, {
              x: 4,
              y: 34
            }, {
              x: 5,
              y: 42
            }]
          }]
        });
        c.render(); {
          var h = function() {
            c.configure({
              width: $("#charts-column").width(),
              height: $("#charts-column").height()
            }), c.render()
          };
          new Rickshaw.Graph.HoverDetail({
            graph: c
          })
        }
        window.addEventListener("resize", h), h();
        for (var r = [
            [],
            [],
            []
          ], s = new Rickshaw.Fixtures.RandomData(100), i = 0; 100 > i; i++) s.addData(r);
        var g = new Rickshaw.Graph({
          element: document.getElementById("charts-legend"),
          renderer: "area",
          width: $("#charts-legend").width(),
          series: [{
            color: "#2D3349",
            data: r[0],
            name: "Total"
          }, {
            color: "#4FB5DD",
            data: r[1],
            name: "New"
          }, {
            color: "#F04E51",
            data: r[2],
            name: "Returned"
          }]
        });
        g.render();
        var m = new Rickshaw.Graph.Legend({
            graph: g,
            element: document.getElementById("legend")
          }),
          u = (new Rickshaw.Graph.Behavior.Series.Toggle({
            graph: g,
            legend: m
          }), new Rickshaw.Graph.Behavior.Series.Order({
            graph: g,
            legend: m
          }), new Rickshaw.Graph.Behavior.Series.Highlight({
            graph: g,
            legend: m
          }), function() {
            g.configure({
              width: $("#charts-legend").width(),
              height: $("#charts-legend").height()
            }), g.render()
          });
        window.addEventListener("resize", u), u()
      }
    },
    chartjs: function() {
      if (0 === $("#chartjs_line").length) return !1;
      window.chartColors = {
        red: "rgb(239, 64, 67)",
        orange: "rgb(246, 159, 0)",
        yellow: "rgb(242, 255, 37)",
        green: "rgb(118, 171, 60)",
        blue: "rgb(79, 181, 221)",
        purple: "rgb(153, 102, 255)",
        grey: "rgb(231,233,237)"
      }, window.randomScalingFactor = function() {
        return (Math.random() > .5 ? 1 : -1) * Math.round(100 * Math.random())
      };
      var a = {
          type: "line",
          data: {
            labels: ["January", "February", "March", "April", "May", "June", "July"],
            datasets: [{
              label: "My First dataset",
              backgroundColor: window.chartColors.red,
              borderColor: window.chartColors.red,
              data: [randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor()],
              fill: !1
            }, {
              label: "My Second dataset",
              fill: !1,
              backgroundColor: window.chartColors.blue,
              borderColor: window.chartColors.blue,
              data: [randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor()]
            }]
          },
          options: {
            responsive: !0,
            title: {
              display: !0,
              text: "Chart.js Line Chart"
            },
            tooltips: {
              mode: "index",
              intersect: !1
            },
            hover: {
              mode: "nearest",
              intersect: !0
            },
            scales: {
              xAxes: [{
                display: !0,
                scaleLabel: {
                  display: !0,
                  labelString: "Month"
                }
              }],
              yAxes: [{
                display: !0,
                scaleLabel: {
                  display: !0,
                  labelString: "Value"
                }
              }]
            }
          }
        },
        e = Chart.helpers.color,
        t = {
          labels: ["January", "February", "March", "April", "May", "June", "July"],
          datasets: [{
            label: "Dataset 1",
            backgroundColor: e(window.chartColors.red).alpha(.5).rgbString(),
            borderColor: window.chartColors.red,
            borderWidth: 1,
            data: [randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor()]
          }, {
            label: "Dataset 2",
            backgroundColor: e(window.chartColors.blue).alpha(.5).rgbString(),
            borderColor: window.chartColors.blue,
            borderWidth: 1,
            data: [randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor()]
          }]
        },
        i = function() {
          return Math.round(100 * Math.random())
        },
        n = {
          type: "radar",
          data: {
            labels: ["Eating", "Drinking", "Sleeping", "Designing", "Coding", "Cycling", "Running"],
            datasets: [{
              label: "My First dataset",
              backgroundColor: e(window.chartColors.red).alpha(.2).rgbString(),
              borderColor: window.chartColors.red,
              pointBackgroundColor: window.chartColors.red,
              data: [i(), i(), i(), i(), i(), i(), i()]
            }, {
              label: "My Second dataset",
              backgroundColor: e(window.chartColors.blue).alpha(.2).rgbString(),
              borderColor: window.chartColors.blue,
              pointBackgroundColor: window.chartColors.blue,
              data: [i(), i(), i(), i(), i(), i(), i()]
            }]
          },
          options: {
            legend: {
              position: "top"
            },
            title: {
              display: !0,
              text: "Chart.js Radar Chart"
            },
            scale: {
              ticks: {
                beginAtZero: !0
              }
            }
          }
        },
        o = {
          data: {
            datasets: [{
              data: [i(), i(), i(), i(), i()],
              backgroundColor: [e(chartColors.red).alpha(.5).rgbString(), e(chartColors.orange).alpha(.5).rgbString(), e(chartColors.yellow).alpha(.5).rgbString(), e(chartColors.green).alpha(.5).rgbString(), e(chartColors.blue).alpha(.5).rgbString()],
              label: "My dataset"
            }],
            labels: ["Red", "Orange", "Yellow", "Green", "Blue"]
          },
          options: {
            responsive: !0,
            legend: {
              position: "right"
            },
            title: {
              display: !0,
              text: "Chart.js Polar Area Chart"
            },
            scale: {
              ticks: {
                beginAtZero: !0
              },
              reverse: !1
            },
            animation: {
              animateRotate: !1,
              animateScale: !0
            }
          }
        },
        r = {
          type: "pie",
          data: {
            datasets: [{
              data: [i(), i(), i(), i(), i()],
              backgroundColor: [window.chartColors.red, window.chartColors.orange, window.chartColors.yellow, window.chartColors.green, window.chartColors.blue],
              label: "Dataset 1"
            }],
            labels: ["Red", "Orange", "Yellow", "Green", "Blue"]
          },
          options: {
            responsive: !0
          }
        },
        s = {
          type: "doughnut",
          data: {
            datasets: [{
              data: [i(), i(), i(), i(), i()],
              backgroundColor: [window.chartColors.red, window.chartColors.orange, window.chartColors.yellow, window.chartColors.green, window.chartColors.blue],
              label: "Dataset 1"
            }],
            labels: ["Red", "Orange", "Yellow", "Green", "Blue"]
          },
          options: {
            responsive: !0
          }
        };
      window.onload = function() {
        var e = document.getElementById("chartjs_line").getContext("2d");
        window.myLine = new Chart(e, a);
        var i = document.getElementById("chartjs_bar").getContext("2d");
        window.myBar = new Chart(i, {
          type: "bar",
          data: t,
          options: {
            responsive: !0,
            legend: {
              position: "top"
            },
            title: {
              display: !0,
              text: "Chart.js Bar Chart"
            }
          }
        }), window.myRadar = new Chart(document.getElementById("chartjs_radar"), n);
        var l = document.getElementById("chartjs_area");
        window.myPolarArea = Chart.PolarArea(l, o);
        var p = document.getElementById("chartjs_pie").getContext("2d");
        window.myPie = new Chart(p, r);
        var d = document.getElementById("chartjs_doughnut").getContext("2d");
        window.myDoughnut = new Chart(d, s)
      }
    }
  }
};
$(function() {
  app_demo.googlemap(), app_demo.jvectormap(), app_demo.solutions.bank.change_password(), app_demo.solutions.bank.change_pin(), app_demo.charts.morris(), app_demo.charts.rickshaw(), app_demo.charts.chartjs(), setTimeout(function() {
  }, 1e3)
});
