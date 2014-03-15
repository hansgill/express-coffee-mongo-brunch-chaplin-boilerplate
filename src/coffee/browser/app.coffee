$(document).ready ()->
	$(".donate").click (ev)->
		formData = new FormData()
		console.dir $(ev.currentTarget)
		formData.append("campaignId", $(ev.currentTarget).attr("data-campaign-id"))
		formData.append("amount",$("#donationAmount").val())
		console.dir formData
		oReq = new XMLHttpRequest()
		oReq.open("POST", "/api/donate")
		oReq.onreadystatechange = ()->
      if oReq.readyState is 4 and oReq.status is 200
        alert "Donation successful"
        window.location = "/campaigns"
		oReq.send(formData)