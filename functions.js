function getMainParams() {
    return {
        mainColor: "#24262d",
        mainPadding: 10,
        title: {
            size: 24,
            font: "PT Sans,sans-serif",
            text: passerelle.getAppName(),
        }
    }
}

function getTableViewDatas() {
    passerelle.getTimelineDatas()
}

function setTableViewDatas(datas) {
    let jsonData = JSON.parse(datas)
    jsonData
        .forEach(
            (d) => {
                 appendTableViewData(d);
        }
    )
}

function appendTableViewData(data) {
    let contenu = data.contenu;
    var getDesc = contenu.poste ? contenu.poste + "<br/>" : ""
    getDesc += contenu.description
    let result = {
        etablissement: contenu.titre,
        imageEtablissement: contenu.logo,
        description: getDesc
    }
    timelineModel.append(result)
}
