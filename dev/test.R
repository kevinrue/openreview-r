library(basilisk)

# Creating an environment (note, this is not necessary
# when supplying a BasiliskEnvironment to basiliskStart):
tmploc <- file.path(tempdir(), "my_package_B")
if (!file.exists(tmploc)) {
    setupBasiliskEnv(tmploc, character(0), pip = c("openreview-py==1.0.19"))
}

cl <- basiliskStart(tmploc)

get_client <- function(username, password, baseurl = "https://api.openreview.net") {
    openreview <- reticulate::import("openreview")
    client = openreview$Client(baseurl=baseurl, username=username, password=password)
    client
}

username <- Sys.getenv("OPENREVIEW_USERNAME")
password <- Sys.getenv("OPENREVIEW_PASSWORD")

client <- basiliskRun(proc=cl, get_client, username = username, password = password)

my_profile <- client$get_profile()

str(my_profile)
class(my_profile)

my_profile['active']
my_profile$content

basiliskStop(cl)
