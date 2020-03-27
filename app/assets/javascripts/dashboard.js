window.onload = function () {

// Toma la información enviada por el servidor
const expenses01 = $('#chartContainer01').data('expenses');

// Crea el arreglo que contendrá los arreglos de datos para la primer gráfica
let dataarray01 = [];

// Lee la información de expenses01
let i,j,k;
for (i = 0; i < expenses01.length; i++) {
	temp = [];
	for (j= 0; j < expenses01[i][2].length; j++) {
		// Asigna en el arreglo dataarray01 los  arreglos que requiere CanvasJS para el gráfico
		temp.push(
		{
				y : expenses01[i][2][j][2], 
				x : new Date(expenses01[i][2][j][0],expenses01[i][2][j][1] -1)
		})	
	}

	dataarray01.push(
	{
		type: "stackedColumn",
		showInLegend: true,
		color: expenses01[i][1],
		name: expenses01[i][0],
		dataPoints: temp
	});
}

// Crea la gráfica con base en los datos previos
const chart01 = new CanvasJS.Chart("chartContainer01", {
	backgroundColor: "#33373a",
	animationEnabled: true,
	
	// Nombres de los gastos en el eje X 
	legend: {
		fontColor: "white"
	},

	// Propiedades del Eje X
	axisX: {
		interval: 1,
		intervalType: "month",
		labelFontColor: "white"
	},

	// Propiedades del Eje Y
	axisY: {
		valueFormatString: "$#0,,.M",
		labelFontColor: "white"
	},

	// ToolTips al momento de pasar el cursor sobre el gŕafico
	toolTip: {
		shared: true,
		content: toolTipContent
	},

	// Los datos propiamente dichos
	data: dataarray01
});
chart01.render();

function toolTipContent(e) {
	var str = "";
	var total = 0;
	var str2, str3;
	for (var i = 0; i < e.entries.length; i++){
		var  str1 = "<span style= \"color:"+e.entries[i].dataSeries.color + "\"> "+e.entries[i].dataSeries.name+"</span>: $<strong>"+e.entries[i].dataPoint.y+"</strong><br/>";
		total = e.entries[i].dataPoint.y + total;
		str = str.concat(str1);
	}
	str2 = "<span style = \"color:DodgerBlue;\"><strong>"+(e.entries[0].dataPoint.x).getFullYear()+"-"+((e.entries[0].dataPoint.x).getMonth()+1)+"</strong></span><br/>";
	total = Math.round(total * 100) / 100;
	str3 = "<span style = \"color:Tomato\">Total:</span><strong> $"+total+"</strong><br/>";
	return (str2.concat(str)).concat(str3);
}


// Toma la información enviada por el servidor
const expenses02 = $('#chartContainer02').data('expenses');

// Crea el arreglo que contendrá los arreglos de datos para la primer gráfica
let dataarray02 = [];

// Lee la información de expenses02
for (i = 0; i < expenses02.length; i++) {
	temp = [];
	for (j= 0; j < expenses02[i][2].length; j++) {
		temp.push({
			label : expenses02[i][2][j][0], 
			y : expenses02[i][2][j][1]
		})
	}	

	dataarray02.push({
		type: "column",
		name: expenses02[i][0],
		legendText: expenses02[i][0],
		color: expenses02[i][1],
		showInLegend: true, 
		dataPoints: temp
	})
}

const chart02 = new CanvasJS.Chart("chartContainer02", {
	backgroundColor: "#33373a",
	animationEnabled: true,
	toolTip: {
		shared: true
	},
	legend: {
		cursor:"pointer",
		itemclick: toggleDataSeries,
		fontColor: "white"
	},
	axisX: {
		title: "Día del mes actual",
		interval: 1,
		labelFontColor: "white"
	},
	axisY: {
		valueFormatString: "$#0,,.M",
		labelFontColor: "white"
	},
	data: dataarray02
});
chart02.render();

function toggleDataSeries(e) {
	if (typeof(e.dataSeries.visible) === "undefined" || e.dataSeries.visible) {
		e.dataSeries.visible = false;
	}
	else {
		e.dataSeries.visible = true;
	}
	chart02.render();
}

// Toma la información enviada por el servidor
const expenses03 = $('#chartContainer03').data('expenses');

// Crea el arreglo que contendrá los arreglos de datos para la primer gráfica
let dataarray03 = [];

// Lee la información de expenses03
temp = [];
for (i = 0; i < expenses03.length; i++) {
	temp.push({
		label : expenses03[i][0], 
		y : expenses03[i][1]
	})
}
	
dataarray03.push({
	type: "doughnut",
	startAngle: 60,
	//innerRadius: 60,
	indexLabelFontSize: 17,
	indexLabelFontColor: "white",
	indexLabel: "{label} - #percent%",
	toolTipContent: "<b>{label}:</b> {y} (#percent%)",
	dataPoints: temp
})

const chart03 = new CanvasJS.Chart("chartContainer03", {
	backgroundColor: "#33373a",
	animationEnabled: true,
	data: dataarray03
});
chart03.render();

// Toma la información enviada por el servidor
const expenses04 = $('#chartContainer04').data('expenses');

// Crea el arreglo que contendrá los arreglos de datos para la primer gráfica
let dataarray04 = [];

// Lee la información de expenses03
let names = [];
let colors = [];

names[0] = "Mes Anterior";
colors[0] = "#ff66cc";

names[1] = "Mes Actual";
colors[1] = "#66ffff";
for (i = 0; i < expenses04.length; i++) {
	temp = [];
	for (j = 0; j < expenses04[i].length; j++) {
		temp.push({
			x : expenses04[i][j][0], 
			y : expenses04[i][j][1]
		})
	}
	dataarray04.push({
		type: "splineArea",
		showInLegend: true,
		color: colors[i],
		name: names[i],
		dataPoints: temp
	})
}

const chart04 = new CanvasJS.Chart("chartContainer04", {
	backgroundColor: "#33373a",
	animationEnabled: true,
	axisX :{
		interval: 1,
		labelFontColor: "white"
	},
	axisY :{
		valueFormatString: "#0,,.M",
		prefix: "$",
		labelFontColor: "white"
	},
	toolTip: {
		shared: true
	},
	legend: {
		fontColor: "white"
	},
	data: dataarray04
});

chart04.render();


}