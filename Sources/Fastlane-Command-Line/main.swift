let resourceDirectory = ""
let client = FastlaneClient(username: "", password: "", team: "", resourcesDirectoryPath: resourceDirectory)
let profileName = ""

do {
//    let certs = try client.addAvailableIOSCertificates(profileName: profileName).sorted { (cert1, cert2) -> Bool in
//        guard let name1 = cert1.name, let name2 = cert2.name else {
//            return true
//        }
//        return name1.compare(name2) != .orderedDescending
//    }
//

    
//    let allCerts = try client.iOSCertificates()
//    let profileCerts = try client.iOSCertificates(profileName: profileName, availableiOSCertificates: allCerts)
//    let availableCertsToAdd = try client.iOSCertificatesAvailableForAdd(availableCerts: allCerts, profileCerts: profileCerts)
//    for cert in availableCertsToAdd {
//        cert.printDebugDescription()
//        print("\n")
//    }
    
    let response = try client.getProfileResponse(profileName: profileName)
    for profile in response.profiles! {
        print(profile.name!)
        print(profile.uuid)        
    }
    
    if let availCerts = response.availableCertificates {
        for cert in availCerts {
            cert.printDebugDescription()
        }        
    }

} catch let clientError as FastLaneClientError {
    print(clientError.reason)
}

