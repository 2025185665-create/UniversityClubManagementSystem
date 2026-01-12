// ===== Simple Interactivity =====

// Confirm before deleting club/member/event
function confirmDelete(entity, name) {
    return confirm(`Are you sure you want to delete this ${entity}: ${name}?`);
}

// Pie chart placeholder animation (replace with chart library later)
window.addEventListener('load', () => {
    const chart = document.getElementById('pieChart');
    if(chart) {
        chart.innerHTML = "Pie Chart will be here (use Chart.js for real chart)";
        chart.style.color = "#3b82f6";
        chart.style.fontWeight = "bold";
    }
});

// Optional: Table search filter
function filterTable(inputId, tableId) {
    const input = document.getElementById(inputId).value.toLowerCase();
    const rows = document.getElementById(tableId).getElementsByTagName("tr");
    for(let i = 1; i < rows.length; i++){
        rows[i].style.display = rows[i].innerText.toLowerCase().includes(input) ? "" : "none";
    }
}
