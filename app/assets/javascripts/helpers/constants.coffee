# ==========================================================================
# Constants 
# ==========================================================================
# A file of constants used throughout the frontend app.
#

window.Permissions = {
	VIEW: 1 << 0
	DOWNLOAD: 1 << 1
	POST: 1 << 2
	EDIT: 1 << 3
}

window.EventTypes = [{
	type: "bounce",
	name: "Bounce"
}, {
	type: "click",
	name: "Click"
}, {
	type: "deferred",
	name: "Deferred"
}, {
	type: "delivered",
	name: "Delivered"
}, {
	type: "dropped",
	name: "Dropped"
}, {
	type: "group_resubscribe",
	name: "Group Resubscribe"
}, {
	type: "group_unsubscribe",
	name: "Group Unsubscribe"
}, {
	type: "open",
	name: "Open"
}, {
	type: "processed",
	name: "Processed"
}, {
	type: "spamreport",
	name: "Spam Report"
}, {
	type: "unsubscribe",
	name: "Unsubscribe"
}]