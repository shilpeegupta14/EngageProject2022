//
//  resource_bundle_accessor.swift
//  FaceRecogDeviceSecurity
//
//  Created by Shilpee Gupta on 25/05/22.
//

import class Foundation.Bundle

private class BundleFinder {}

extension Foundation.Bundle {
    /// Returns the resource bundle associated with the current Swift module.
    static var module: Bundle = {
        let bundleName = "FaceRecogDeviceSecurity_FaceRecogDeviceSecurity"

        let candidates = [
            // Bundle should be present here when the package is linked into an App.
            Bundle.main.resourceURL,

            // Bundle should be present here when the package is linked into a framework.
            Bundle(for: BundleFinder.self).resourceURL,
            
            Bundle(for: BundleFinder.self).resourceURL?.deletingLastPathComponent(),

            // For command-line tools.
            Bundle.main.bundleURL,
            
//            /* Bundle should be present here when the package is linked into an App. */
//                  Bundle.main.resourceURL,
//                  /* Bundle should be present here when the package is linked into a framework. */
//                  Bundle(for: CurrentBundleFinder.self).resourceURL,
//                  /* Bundle should be present here when the package is used in UI Tests. */
//                  Bundle(for: CurrentBundleFinder.self).resourceURL?.deletingLastPathComponent(),
//                  /* For command-line tools. */
//                  Bundle.main.bundleURL,
//                  /* Bundle should be present here when running previews from a different package (this is the path to "…/Debug-iphonesimulator/"). */
//                  Bundle(for: CurrentBundleFinder.self).resourceURL?.deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent(),
//                  Bundle(for: CurrentBundleFinder.self).resourceURL?.deletingLastPathComponent().deletingLastPathComponent()
        ]

        for candidate in candidates {
            let bundlePath = candidate?.appendingPathComponent(bundleName + ".bundle")
            if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
                return bundle
            }
        }
        fatalError("unable to find bundle named FaceRecogDeviceSecurity_FaceRecogDeviceSecurity")
    }()
}
