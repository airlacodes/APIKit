//
//  ViewController.swift
//  SampleApp
//
//  Created by Jeevan Thandi on 07/07/2019.
//  Copyright © 2019 Airla Tech Ltd. All rights reserved.
//

import UIKit
import APIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // create a call
        let endpoint = Endpoint(path: "https://jsonplaceholder.typicode.com/posts/1)",
                                method: .get)
        let call = APICall<Post>(endpoint:endpoint)

        call.execute(callback: { response in
            switch response {
            case .success(let post): print("POST: ", post)
            case .failure(let error): print("error: ", error)
            }
        })


        // use a prebuilt static call
        API.getPost(id: 1).execute(callback: { response in
            switch response {
            case .success(let post): print("POST: ", post)
            case .failure(let error): print("error: ", error)
            }
        })
    }
}
