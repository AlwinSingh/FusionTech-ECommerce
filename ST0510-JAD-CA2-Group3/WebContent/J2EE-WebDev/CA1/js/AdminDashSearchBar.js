	function filterData() {
		var input, filter, table, tr, td, i, txtValue;
		input = document.getElementById("searchTerm");
		filter = input.value.toUpperCase();
		table = document.getElementById("tbl-content");
		tr = table.getElementsByTagName("tr");
		for (i = 0; i < tr.length; i++) {
			td1 = tr[i].getElementsByTagName("td")[0];
			td2 = tr[i].getElementsByTagName("td")[1];
			td3 = tr[i].getElementsByTagName("td")[2];
			td4 = tr[i].getElementsByTagName("td")[3];
			td5 = tr[i].getElementsByTagName("td")[4];
			td6 = tr[i].getElementsByTagName("td")[5];
			td7 = tr[i].getElementsByTagName("td")[6];
			td8 = tr[i].getElementsByTagName("td")[7];
			if (td1 || td2 || td3 || td4 || td5 || td6 || td7 || td8) {
				txtValue1 = td1.textContent || td1.innerText;
				txtValue2 = td2.textContent || td2.innerText;
				txtValue3 = td3.textContent || td3.innerText;
				txtValue4 = td4.textContent || td4.innerText;
				txtValue5 = td5.textContent || td5.innerText;
				txtValue6 = td6.textContent || td6.innerText;
				txtValue7 = td7.textContent || td7.innerText;
				txtValue8 = td8.textContent || td8.innerText;
				if (txtValue1.toUpperCase().indexOf(filter) > -1
						|| txtValue2.toUpperCase().indexOf(filter) > -1
						|| txtValue3.toUpperCase().indexOf(filter) > -1
						|| txtValue4.toUpperCase().indexOf(filter) > -1
						|| txtValue5.toUpperCase().indexOf(filter) > -1
						|| txtValue6.toUpperCase().indexOf(filter) > -1
						|| txtValue7.toUpperCase().indexOf(filter) > -1
						|| txtValue8.toUpperCase().indexOf(filter) > -1) {
					tr[i].style.display = "";
				} else {
					tr[i].style.display = "none";
				}
			}
		}
	}