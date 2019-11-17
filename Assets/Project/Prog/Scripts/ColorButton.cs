using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using VRTK;
using VRTK.Controllables;
using VRTK.Controllables.ArtificialBased;

public class ColorButton : MonoBehaviour {

    VRTK_ArtificialPusher _pusher;


	void Start () {
        _pusher = GetComponent<VRTK_ArtificialPusher>();
        _pusher.MinLimitExited += (object sender, ControllableEventArgs e) => 
        {
            CubeInstanciater.Instance.ChangeSelectedCube(tag);
        };
	}

	/*void Update () {
        if (_pusher.pressedDistance > 1)
        {
            CubeInstanciater.Instance.ChangeSelectedCube(tag);
        }
	}*/
}
