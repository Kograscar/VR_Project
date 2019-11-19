using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using VRTK.Controllables;
using VRTK.Controllables.ArtificialBased;

public class AddOrRemoveLoadedCube : MonoBehaviour {

    VRTK_ArtificialPusher _lessPusher;
    VRTK_ArtificialPusher _morePusher;

    CubeLoader _cubeLoader;

    private void OnEnable()
    {
        _cubeLoader = GetComponentInParent<CubeLoader>();

        //_lessPusher.MinLimitExited += (object sender, ControllableEventArgs e){
       
    }
}
