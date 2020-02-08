//
//  FastlaneCertificate.swift
//  Fastlane
//
//  Created by Bill Gestrich on 2/6/20.
//

import Foundation

public class FastlaneCertificate: Codable, Hashable {
    public var id: String
    public var name: String?
    public var status: String?
    public var created: String?
    public var expires: String?
    public var owner_type: String?
    public var owner_name: String?
    public var owner_id: String?
    public var type_display_id: String?
    public var can_download: String?
    
    // MARK - Hashable
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    public static func == (lhs: FastlaneCertificate, rhs: FastlaneCertificate) -> Bool {
        return lhs.id == rhs.id
    }
    
    func printDebugDescription(){
        print("Owner name: " + self.owner_name!)
        print("Profile Name: " + self.name!)
        print("ID: " + self.id)
        print("Expires: " + self.expires!)
        print("Owner ID: " + self.owner_id!)
        print("Owner Type: " + self.owner_type!)
        print("Status: " + self.status!)
        print("Display ID: " + self.type_display_id!)
    }
    
    public static func sortCertificatesByName(certificates: [FastlaneCertificate]) -> [FastlaneCertificate] {
        return certificates.sorted(by: { (cert1, cert2) -> Bool in
            let name1 = cert1.owner_name?.lowercased() ?? ""
            let name2 = cert2.owner_name?.lowercased() ?? ""
            return name1.compare(name2) == ComparisonResult.orderedAscending
        })
    }
}

public class FastLaneCerticateFetchResult: Codable {
    public var result: [FastlaneCertificate]
    public var error: String?
}
