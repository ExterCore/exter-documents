var idCards = {};
menuOpen = false;
translations = [];
window.addEventListener('message', function(event) {
    ed = event.data;
    if (ed.action === "openIdCard") {
		translations = ed.translations;
		showIdCard(ed.metadata);
	} else if (ed.action === "openCityHall") {
		translations = ed.translations;
		$("#buyIDCDiv").fadeIn().css({top: "-20%", position:'relative', display:'flex'}).animate({top: "0"}, 800, function() {
			document.getElementById("buyIDCDivTopEffect").style.display = "block";
		});
		menuOpen = true;
		let label1 = "";
		if (ed.label.split(" ")[0]) {
			label1 = ed.label.split(" ")[0];
		}
		let label2 = "";
		if (ed.label.split(" ")[1]) {
			label2 = ed.label.split(" ")[1];
		}
		document.getElementById("menuLabel").innerHTML=`${label1}<span style="font-weight: 400;">${label2}</span>`;
		document.getElementById("buyIDCDivBottom").innerHTML="";
		ed.items.forEach(function(itemData, index) {
			if (itemData.job) {
				if (itemData.job === ed.enabledJob) {
					let itemLabel1 = "";
					if (itemData.label.split(" ")[0]) {
						itemLabel1 = itemData.label.split(" ")[0];
					}
					let itemLabel2 = "";
					if (ed.label.split(" ")[1]) {
						itemLabel2 = itemData.label.split(" ")[1];
					}
					let itemLabel3 = itemData.label;
					if (itemLabel3.length > 11) {
						itemLabel3 = itemLabel3.slice(0, 11) + "...";
					}
					var itemsHTML = `
					<div id="buyIDCDivBottomItemDiv" onmouseenter="clFunc('openHover', '${itemData.name}')" onmouseleave="clFunc('closeHover', '${itemData.name}')">
						<div class="buyIDCDBottomItemDivBuyDiv" id="buyIDCDBottomItemDivBuyDiv-${itemData.name}">
							<div style="width: fit-content; height: fit-content; position: relative; display: flex; align-items: center; justify-content: center; flex-direction: column; gap: 0.4vw;">
								<i class="fas fa-shopping-basket" style="font-size: 0.9vw;"></i>
								<h4 style="font-weight: 900; font-size: 0.7vw;">1X<span style="font-weight: 400;"> ${itemLabel3}</span></h4>
								<div id="buyIDCDBottomItemDivBuyDivButton" onclick="clFunc('buy', '${itemData.name}', '${itemData.price}')"><h4>${translations.buy}</h4></div>
							</div>
						</div>
						<img src="files/${itemData.name}.png" id="buyIDCDivBottomItemDivImage">
						<h4 style="font-weight: 900; font-size: 0.75vw;">${itemLabel1} <span style="font-weight: 400;">${itemLabel2}</span></h4>
						<div id="buyIDCDBottomItemDivPrice"><h4>${itemData.price}$</h4></div>
					</div>`;
					appendHtml(document.getElementById("buyIDCDivBottom"), itemsHTML);
				} else {
					let itemLabel1 = "";
					if (itemData.label.split(" ")[0]) {
						itemLabel1 = itemData.label.split(" ")[0];
					}
					let itemLabel2 = "";
					if (ed.label.split(" ")[1]) {
						itemLabel2 = itemData.label.split(" ")[1];
					}
					let itemLabel3 = itemData.label;
					if (itemLabel3.length > 11) {
						itemLabel3 = itemLabel3.slice(0, 11) + "...";
					}
					var itemsHTML = `
					<div id="buyIDCDivBottomItemDiv" style="opacity: 0.4;">
						<div class="buyIDCDBottomItemDivBuyDiv" id="buyIDCDBottomItemDivBuyDiv-${itemData.name}">
							<div style="width: fit-content; height: fit-content; position: relative; display: flex; align-items: center; justify-content: center; flex-direction: column; gap: 0.4vw;">
								<i class="fas fa-shopping-basket" style="font-size: 0.9vw;"></i>
								<h4 style="font-weight: 900; font-size: 0.7vw;">1X<span style="font-weight: 400;"> ${itemLabel3}</span></h4>
								<div id="buyIDCDBottomItemDivBuyDivButton" onclick="clFunc('buy', '${itemData.name}', '${itemData.price}')"><h4>${translations.buy}</h4></div>
							</div>
						</div>
						<img src="files/${itemData.name}.png" id="buyIDCDivBottomItemDivImage">
						<h4 style="font-weight: 900; font-size: 0.75vw;">${itemLabel1} <span style="font-weight: 400;">${itemLabel2}</span></h4>
						<div id="buyIDCDBottomItemDivPrice"><h4>${itemData.price}$</h4></div>
					</div>`;
					appendHtml(document.getElementById("buyIDCDivBottom"), itemsHTML);
				}
			} else {
				let itemLabel1 = "";
				if (itemData.label.split(" ")[0]) {
					itemLabel1 = itemData.label.split(" ")[0];
				}
				let itemLabel2 = "";
				if (ed.label.split(" ")[1]) {
					itemLabel2 = itemData.label.split(" ")[1];
				}
				let itemLabel3 = itemData.label;
				if (itemLabel3.length > 11) {
					itemLabel3 = itemLabel3.slice(0, 11) + "...";
				}
				var itemsHTML = `
				<div id="buyIDCDivBottomItemDiv" onmouseenter="clFunc('openHover', '${itemData.name}')" onmouseleave="clFunc('closeHover', '${itemData.name}')">
					<div class="buyIDCDBottomItemDivBuyDiv" id="buyIDCDBottomItemDivBuyDiv-${itemData.name}">
						<div style="width: fit-content; height: fit-content; position: relative; display: flex; align-items: center; justify-content: center; flex-direction: column; gap: 0.4vw;">
							<i class="fas fa-shopping-basket" style="font-size: 0.9vw;"></i>
							<h4 style="font-weight: 900; font-size: 0.7vw;">1X<span style="font-weight: 400;"> ${itemLabel3}</span></h4>
							<div id="buyIDCDBottomItemDivBuyDivButton" onclick="clFunc('buy', '${itemData.name}', '${itemData.price}')"><h4>${translations.buy}</h4></div>
						</div>
					</div>
					<img src="files/${itemData.name}.png" id="buyIDCDivBottomItemDivImage">
					<h4 style="font-weight: 900; font-size: 0.75vw;">${itemLabel1} <span style="font-weight: 400;">${itemLabel2}</span></h4>
					<div id="buyIDCDBottomItemDivPrice"><h4>${itemData.price}$</h4></div>
				</div>`;
				appendHtml(document.getElementById("buyIDCDivBottom"), itemsHTML);
			}
		});
	} else if (ed.action === "convert") {
		Convert(ed.pMugShotTxd, ed.removeImageBackGround, ed.id);
	}
	document.onkeyup = function(data) {
		if (data.which == 27 && menuOpen) {
            menuOpen = false;
			$("#buyIDCDiv").fadeIn().css({top: "0%", position:'relative', display:'flex'}).animate({top: "-20%"}, 800, function() {
				document.getElementById("buyIDCDivTopEffect").style.display = "none";
				document.getElementById("buyIDCDiv").style.display = "none";
			});
			var xhr = new XMLHttpRequest();
			xhr.open("POST", `https://${GetParentResourceName()}/callback`, true);
			xhr.setRequestHeader('Content-Type', 'application/json');
			xhr.send(JSON.stringify({action: "nuiFocus"}));
		}
	}
});

document.getElementById("buyIDCDivBottom").addEventListener("wheel", event => {
	var delta = event.deltaY / 2.5;
    var scrollLeft = document.getElementById("buyIDCDivBottom").scrollLeft;
	document.getElementById("buyIDCDivBottom").scrollLeft = scrollLeft + delta;
    event.preventDefault();
});

function clFunc(name1, name2, name3) {
	if (name1 === "openHover") {
		document.getElementById("buyIDCDBottomItemDivBuyDiv-" + name2).style.display = "flex";
	} else if (name1 === "closeHover") {
		document.getElementById("buyIDCDBottomItemDivBuyDiv-" + name2).style.display = "none";
	} else if (name1 === "buy") {
		var xhr = new XMLHttpRequest();
		xhr.open("POST", `https://${GetParentResourceName()}/callback`, true);
		xhr.setRequestHeader('Content-Type', 'application/json');
		xhr.send(JSON.stringify({action: "buy", item: name2, price: Number(name3)}));
	}
}

function createIdCard(data) {
	let label = null;
	let label2 = null;
	let label3 = null;
	let label4 = null;
	let label5 = null;
	if (data.type === "idcard") {
		label = translations.identity_card;
		label2 = translations.nationality;
		label3 = data.nationality;
		label4 = translations.citizenship;
		label5 = data.citizenship;
	} else if (data.type === "driverlicense") {
		label = translations.driver_license;
		label2 = translations.class;
		label3 = "A/B/C";
		label4 = translations.citizenship;
		label5 = data.citizenship;
	} else if (data.type === "lspdbadge") {
		label = translations.lspd_badge;
		label2 = translations.job;
		label3 = data.citizenship;
		label4 = translations.grade;
		label5 = data.class;
	} else if (data.type === "lsmsbadge") {
		label = translations.lsms_badge;
		label2 = translations.job;
		label3 = data.citizenship;
		label4 = translations.grade;
		label5 = data.class;
	} else if (data.type === "weaponlicense") {
		label = translations.weapon_license;
		label2 = translations.weapon;
		label3 = data.citizenship;
		label4 = translations.class;
		label5 = data.class;
	} else if (data.type === "huntinglicense") {
		label = translations.hunting_license;
		label2 = translations.weapon;
		label3 = data.citizenship;
		label4 = translations.class;
		label5 = data.class;
	}
	let signature = data.firstName.charAt(0) + data.lastName.charAt(0);
	let image = data.image;
	if (image === "default") {
		if (data.sex === "MALE" || data.sex === "male" || data.sex === "Male" || data.sex === "M" || data.sex === "m") {
			image = "files/male.png";
		} else {
			image = "files/female.png";
		}
	}
	let $idcard = $(document.createElement('div'));
	$idcard.addClass(data.type + "-container");
	$idcard.css('display', 'flex');
	$idcard.html(`
	<div id="IDCTopDiv">
		<div id="IDCTopDivBarrier" style="clip-path: polygon(5% 0, 100% 0, 95% 100%, 0 100%)"></div>
		<div id="IDCTopDivCenter">
			<h4 style="letter-spacing: 0.5px; font-size: 0.9vw;">LOS SANTOS</h4>
			<h4 style="font-weight: 500; letter-spacing: 1px; font-size: 0.65vw;">${label}</h4>
		</div>
		<div id="IDCTopDivBarrier" style="clip-path: polygon(0% 0%, 95% 0%, 100% 100%, 5% 100%)"></div>
	</div>
	<div id="IDCBottomDiv">
		<div id="IDCBDImageDiv">
			<img src="${image}" id="IDCBottomDivImg">
			<h4 style="position: absolute; left: 0; bottom: 0; transform: translate(10px, 20px) rotate(-15deg); font-size: 0.7vw; font-family: 'Lampard Signature', sans-serif; color: #3b5ffb;">${signature}</h4>
		</div>
		<div id="IDCBDRightSideDiv">
			<div id="IDCBDRightSideDivColumnDiv">
				<div id="IDCBDRightSideDivColumnDivInside">
					<div id="IDCBDRSDCDIDivTop">
						<h4 style="width: 60%;">FIRST NAME</h4>
						<div id="IDCBDRSDCDIDivTopBarrier"></div>
					</div>
					<div id="IDCBDRSDCDIDivBottom">
						<h4>${data.firstName}</h4>
					</div>
				</div>
				<div id="IDCBDRightSideDivColumnDivInside">
					<div id="IDCBDRSDCDIDivTop">
						<h4 style="width: fit-content;">DOB</h4>
						<div id="IDCBDRSDCDIDivTopBarrier"></div>
					</div>
					<div id="IDCBDRSDCDIDivBottom">
						<h4>${data.dob}</h4>
					</div>
				</div>
				<div id="IDCBDRightSideDivColumnDivInside">
					<div id="IDCBDRSDCDIDivTop">
						<h4 style="width: 50%;">ISSUED ON</h4>
						<div id="IDCBDRSDCDIDivTopBarrier"></div>
					</div>
					<div id="IDCBDRSDCDIDivBottom">
						<h4>${data.issuedon}</h4>
					</div>
				</div>
				<div id="IDCBDRightSideDivColumnDivInside">
					<div id="IDCBDRSDCDIDivTop">
						<h4>${label2}</h4>
						<div id="IDCBDRSDCDIDivTopBarrier"></div>
					</div>
					<div id="IDCBDRSDCDIDivBottom">
						<h4>${label3}</h4>
					</div>
				</div>
			</div>
			<div id="IDCBDRightSideDivColumnDiv">
				<div id="IDCBDRightSideDivColumnDivInside">
					<div id="IDCBDRSDCDIDivTop">
						<h4 style="width: 60%;">LAST NAME</h4>
						<div id="IDCBDRSDCDIDivTopBarrier"></div>
					</div>
					<div id="IDCBDRSDCDIDivBottom">
						<h4>${data.lastName}</h4>
					</div>
				</div>
				<div id="IDCBDRightSideDivColumnDivInside">
					<div id="IDCBDRSDCDIDivTop">
						<h4>GENDER</h4>
						<div id="IDCBDRSDCDIDivTopBarrier"></div>
					</div>
					<div id="IDCBDRSDCDIDivBottom">
						<h4>${data.sex}</h4>
					</div>
				</div>
				<div id="IDCBDRightSideDivColumnDivInside">
					<div id="IDCBDRSDCDIDivTop">
						<h4 style="width: 65%;">EXPIRED ON</h4>
						<div id="IDCBDRSDCDIDivTopBarrier"></div>
					</div>
					<div id="IDCBDRSDCDIDivBottom">
						<h4>${data.expiredon}</h4>
					</div>
				</div>
				<div id="IDCBDRightSideDivColumnDivInside">
					<div id="IDCBDRSDCDIDivTop">
						<h4>${label4}</h4>
						<div id="IDCBDRSDCDIDivTopBarrier"></div>
					</div>
					<div id="IDCBDRSDCDIDivBottom">
						<h4>${label5}</h4>
					</div>
				</div>
			</div>
		</div>
	</div>`);
	$idcard.fadeIn();
	return $idcard;
}

function showIdCard(data) {
	let $idcard = createIdCard(data);
	$('#idCards').append($idcard);
	idCards[data.id] = {
		noti: $idcard,
		timer: setTimeout(function() {
			let $idcard = idCards[data.id].noti;
			$.when($idcard.fadeOut()).done(function() {
				$idcard.remove();
				clearTimeout(idCards[data.id].timer);
				delete idCards[data.id];
			});
		}, 10000)
	};
}

function appendHtml(el, str) {
	var div = document.createElement('div');
	div.innerHTML = str;
	while (div.children.length > 0) {
		el.appendChild(div.children[0]);
	}
}

async function getBase64Image(src, removeImageBackGround, callback, outputFormat) {
	const img = new Image();
	img.crossOrigin = 'Anonymous';
	img.addEventListener("load", () => loadFunc(), false);
	async function loadFunc() {
		const canvas = document.createElement('canvas');
		const ctx = canvas.getContext('2d');
		var convertingCanvas = canvas;
		if (removeImageBackGround) {
			var selectedSize = 320
			canvas.height = selectedSize;
			canvas.width = selectedSize;
			ctx.drawImage(img, 0, 0, selectedSize, selectedSize);
			await removeBackGround(canvas);
			const canvas2 = document.createElement('canvas');
			const ctx2 = canvas2.getContext('2d');
			canvas2.height = 64;
			canvas2.width = 64;
			ctx2.drawImage(canvas, 0, 0, selectedSize, selectedSize, 0, 0, img.naturalHeight, img.naturalHeight);
			convertingCanvas = canvas2;
		} else {
			canvas.height = img.naturalHeight;
			canvas.width = img.naturalWidth;
			ctx.drawImage(img, 0, 0);
		}
		var dataURL = convertingCanvas.toDataURL(outputFormat);
		canvas.remove();
		convertingCanvas.remove();
		img.remove();
		callback(dataURL);
	};
	img.src = src;
	if (img.complete || img.complete === undefined) {
		img.src = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACEAAAAkCAIAAACIS8SLAAAAKklEQVRIie3NMQEAAAgDILV/55nBww8K0Enq2XwHDofD4XA4HA6Hw+E4Wwq6A0U+bfCEAAAAAElFTkSuQmCC";
		img.src = src;
	}
}
  
async function Convert(pMugShotTxd, removeImageBackGround, id) {
	var tempUrl = `https://nui-img/${pMugShotTxd}/${pMugShotTxd}?t=${String(Math.round(new Date().getTime() / 1000))}`;
	// if (pMugShotTxd == 'none') {
	//   	tempUrl = 'https://cdn.discordapp.com/attachments/555420890444070912/983953950652903434/unknown.png';   
	// }
	getBase64Image(tempUrl, removeImageBackGround, function(dataUrl) {
		var xhr = new XMLHttpRequest();
		xhr.open("POST", `https://${GetParentResourceName()}/Answer`, true);
		xhr.setRequestHeader('Content-Type', 'application/json');
		xhr.send(JSON.stringify({Answer: dataUrl, Id: id,}));
	})
}
  
async function removeBackGround(sentCanvas) {
	const canvas = sentCanvas;
	const ctx = canvas.getContext('2d');
	// Loading the model
	const net = await bodyPix.load({
		architecture: 'MobileNetV1',
		outputStride: 16,
		multiplier: 0.75,
		quantBytes: 2
	});
	// Segmentation
	const { data:map } = await net.segmentPerson(canvas, {
	  	internalResolution: 'medium',
	});
	// Extracting image data
	const { data:imgData } = ctx.getImageData(0, 0, canvas.width, canvas.height);
	// Creating new image data
	const newImg = ctx.createImageData(canvas.width, canvas.height);
	const newImgData = newImg.data;
	for (var i=0; i<map.length; i++) {
	  	//The data array stores four values for each pixel
		const [r, g, b, a] = [imgData[i*4], imgData[i*4+1], imgData[i*4+2], imgData[i*4+3]];
		[
		newImgData[i*4],
		newImgData[i*4+1],
		newImgData[i*4+2],
		newImgData[i*4+3]
		] = !map[i] ? [255, 255, 255, 0] : [r, g, b, a];
	}
	// Draw the new image back to canvas
	ctx.putImageData(newImg, 0, 0);
}