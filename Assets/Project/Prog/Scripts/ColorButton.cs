using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using VRTK.Controllables;
using VRTK.Controllables.ArtificialBased;
using TMPro;

public class ColorButton : MonoBehaviour {

    VRTK_ArtificialPusher _pusher;
    
	void Start () {
        _pusher = GetComponent<VRTK_ArtificialPusher>();
        _pusher.MinLimitExited += (object sender, ControllableEventArgs e) => 
        {
            CubeInstanciater.Instance.ChangeSelectedCube(tag);
        };
	}
}
