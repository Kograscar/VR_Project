﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using VRTK.Controllables;
using VRTK.Controllables.ArtificialBased;

public class ChangeActiveColorButton : MonoBehaviour {

    VRTK_ArtificialPusher _pusher;
    
	void OnEnable () {
        _pusher = GetComponent<VRTK_ArtificialPusher>();
        _pusher.MinLimitExited += (object sender, ControllableEventArgs e) => 
        {
            CubeInstanciater.Instance.ChangeSelectedCube(tag);
            Debug.Log(tag);
        };
	}
}
