<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMasterPage.master" AutoEventWireup="true" CodeFile="Chart.aspx.cs" Inherits="Admin_Chart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
  
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        .chart-container {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 40px 20px;
            font-family: 'Poppins', sans-serif;
            position: relative;
            overflow: hidden;
        }

        .chart-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg width="100" height="100" xmlns="http://www.w3.org/2000/svg"><defs><pattern id="grid" width="100" height="100" patternUnits="userSpaceOnUse"><path d="M 100 0 L 0 0 0 100" fill="none" stroke="rgba(255,255,255,0.1)" stroke-width="1"/></pattern></defs><rect width="100%" height="100%" fill="url(%23grid)"/></svg>');
            opacity: 0.3;
            pointer-events: none;
        }

        .chart-wrapper {
            max-width: 1200px;
            margin: 0 auto;
            position: relative;
            z-index: 1;
        }

        .page-title {
            font-size: 42px;
            font-weight: 700;
            color: #fff;
            text-align: center;
            margin-bottom: 50px;
            text-shadow: 0 4px 12px rgba(0,0,0,0.2);
            animation: fadeInDown 0.8s ease;
        }

        .page-title::after {
            content: '';
            display: block;
            width: 100px;
            height: 4px;
            background: linear-gradient(90deg, #fff, transparent);
            margin: 15px auto 0;
            border-radius: 2px;
        }

        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .charts-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(500px, 1fr));
            gap: 30px;
            margin-bottom: 30px;
        }

        .chart-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 35px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.15);
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            animation: fadeInUp 0.6s ease forwards;
            position: relative;
            overflow: hidden;
        }

        .chart-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, transparent 0%, rgba(255,255,255,0.3) 100%);
            opacity: 0;
            transition: opacity 0.4s ease;
        }

        .chart-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.25);
        }

        .chart-card:hover::before {
            opacity: 1;
        }

        .chart-title {
            font-size: 24px;
            font-weight: 600;
            color: #333;
            margin-bottom: 25px;
            text-align: center;
            position: relative;
            z-index: 1;
        }

/* Reduce chart size */
.canvas-wrapper {
    max-width: 360px;   /* ⬅️ control overall size */
    margin: 0 auto;
}

/* Force smaller canvas */
.canvas-wrapper canvas {
    width: 100% !important;
    height: 360px !important; /* ⬅️ pie size */
}

/* Even smaller on mobile */
@media (max-width: 768px) {
    .canvas-wrapper {
        max-width: 280px;
    }

    .canvas-wrapper canvas {
        height: 280px !important;
    }
}

        .legend-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-top: 30px;
            position: relative;
            z-index: 1;
        }

        .legend-item {
            display: flex;
            align-items: center;
            padding: 12px 15px;
            background: rgba(255,255,255,0.5);
            border-radius: 10px;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .legend-item:hover {
            background: rgba(255,255,255,0.8);
            transform: translateX(5px);
        }

        .legend-color {
            width: 20px;
            height: 20px;
            border-radius: 4px;
            margin-right: 12px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .legend-text {
            font-size: 14px;
            color: #555;
            font-weight: 500;
            flex: 1;
        }

        .legend-value {
            font-size: 16px;
            font-weight: 700;
            color: #333;
            margin-left: 10px;
        }

        @media (max-width: 768px) {
            .charts-grid {
                grid-template-columns: 1fr;
            }

            .page-title {
                font-size: 32px;
            }

            .chart-card {
                padding: 20px;
            }

            .legend-container {
                grid-template-columns: 1fr;
            }
        }
    </style>
    <asp:HiddenField ID="TotalCompanies" runat="server" />
    <asp:HiddenField ID="TotalInternships" runat="server" />
    <asp:HiddenField ID="TotalRejectedApplications" runat="server" />
    <asp:HiddenField ID="TotalPendingApplications" runat="server" />
    <asp:HiddenField ID="TotalApprovedApplications" runat="server" />
    <asp:HiddenField ID="TotalStudents" runat="server" />
    
    <div class="chart-container">
        <div class="chart-wrapper">
            <h1 class="page-title">📊 Analytics Dashboard</h1>
            
            <div class="charts-grid">
                <!-- Pie Chart -->
                <div class="chart-card">
                    <h2 class="chart-title">Portal Statistics Overview</h2>
                    <div class="canvas-wrapper">
                        <canvas id="pieChart"></canvas>
                    </div>
                    <div class="legend-container" id="pieLegend"></div>
                </div>

         
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script type="text/javascript">
        window.onload = function () {
            // Get data from hidden fields
            var companies = parseInt('<%= TotalCompanies.Value %>') || 0;
            var internships = parseInt('<%= TotalInternships.Value %>') || 0;
            var rejected = parseInt('<%= TotalRejectedApplications.Value %>') || 0;
            var pending = parseInt('<%= TotalPendingApplications.Value %>') || 0;
            var approved = parseInt('<%= TotalApprovedApplications.Value %>') || 0;
            var students = parseInt('<%= TotalStudents.Value %>') || 0;

            // Color palette
            var colors = {
                companies: '#3498db',
                internships: '#9b59b6',
                rejected: '#e74c3c',
                pending: '#f39c12',
                approved: '#2ecc71',
                students: '#34495e'
            };

            // Pie Chart - Overall Statistics
            var pieCtx = document.getElementById('pieChart').getContext('2d');
            var pieData = {
                labels: ['Companies', 'Internships', 'Students'],
                datasets: [{
                    data: [
                        companies,
                        internships,
                        students
                    ],
                    backgroundColor: [
                        colors.companies,
                        colors.internships,
                        colors.students
                    ],
                    borderWidth: 3,
                    borderColor: '#fff',
                    hoverOffset: 15
                }]
            };

            var pieChart = new Chart(pieCtx, {
                type: 'pie',
                data: pieData,
                options: {
                    responsive: true,
                    maintainAspectRatio: true,

                    onClick: function (evt, elements) {
                        if (elements.length > 0) {
                            clickedIndex = elements[0].index;
                            pieChart.update();
                        }
                    },

                    plugins: {
                        legend: { display: false },

                        tooltip: {
                            enabled: true,
                            callbacks: {
                                label: function (context) {
                                    var index = context.dataIndex;
                                    var value = context.parsed;

                                    // If slice clicked → show only count
                                    if (clickedIndex === index) {
                                        return "Count: " + value;
                                    }

                                    // Default tooltip
                                    var total = context.dataset.data.reduce((a, b) => a + b, 0);
                                    var percent = ((value / total) * 100).toFixed(1);
                                    return context.label + ": " + value + " (" + percent + "%)";
                                }
                            }
                        }
                    },

                    animation: {
                        animateRotate: true,
                        animateScale: true
                    }
                }
            });

            // Create custom legend for pie chart
            createLegend('pieLegend', pieData.labels, pieData.datasets[0].data, pieData.datasets[0].backgroundColor);

            // Doughnut Chart - Application Status Only
            var doughnutCtx = document.getElementById('doughnutChart').getContext('2d');
            var doughnutData = {
                labels: ['Rejected Applications', 'Pending Applications', 'Approved Applications'],
                datasets: [{
                    data: [rejected, pending, approved],
                    backgroundColor: [colors.rejected, colors.pending, colors.approved],
                    borderWidth: 3,
                    borderColor: '#fff',
                    hoverOffset: 15
                }]
            };

            var doughnutChart = new Chart(doughnutCtx, {
                type: 'doughnut',
                data: doughnutData,
                options: {
                    responsive: true,
                    maintainAspectRatio: true,
                    cutout: '65%',
                    plugins: {
                        legend: {
                            display: false
                        },
                        tooltip: {
                            backgroundColor: 'rgba(0,0,0,0.8)',
                            padding: 12,
                            titleFont: { size: 14, weight: 'bold' },
                            bodyFont: { size: 13 },
                            callbacks: {
                                label: function (context) {
                                    var label = context.label || '';
                                    var value = context.parsed || 0;
                                    var total = context.dataset.data.reduce((a, b) => a + b, 0);
                                    var percentage = ((value / total) * 100).toFixed(1);
                                    return label + ': ' + value + ' (' + percentage + '%)';
                                }
                            }
                        }
                    },
                    animation: {
                        animateRotate: true,
                        animateScale: true,
                        duration: 1500,
                        easing: 'easeInOutQuart'
                    }
                }
            });

            // Create custom legend for doughnut chart
            createLegend('doughnutLegend', doughnutData.labels, doughnutData.datasets[0].data, doughnutData.datasets[0].backgroundColor);

            // Function to create custom legend
            function createLegend(containerId, labels, data, colors) {
                var container = document.getElementById(containerId);
                var total = data.reduce((a, b) => a + b, 0);

                labels.forEach(function (label, index) {
                    var item = document.createElement('div');
                    item.className = 'legend-item';

                    var colorBox = document.createElement('div');
                    colorBox.className = 'legend-color';
                    colorBox.style.backgroundColor = colors[index];

                    var text = document.createElement('span');
                    text.className = 'legend-text';
                    text.textContent = label;

                    var value = document.createElement('span');
                    value.className = 'legend-value';
                    var percentage = ((data[index] / total) * 100).toFixed(1);
                    value.textContent = data[index] + ' (' + percentage + '%)';

                    item.appendChild(colorBox);
                    item.appendChild(text);
                    item.appendChild(value);
                    container.appendChild(item);
                });
            }
        };
    </script>
</asp:Content>