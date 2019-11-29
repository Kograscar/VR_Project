using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using VRTK.Controllables;
using VRTK.Controllables.ArtificialBased;

public class ConstructionModeChanger : MonoBehaviour {

    VRTK_ArtificialPusher vRTK_ArtificialPusher;

    bool _construction;

    void Start()
    {
        _construction = true;
        vRTK_ArtificialPusher = GetComponent<VRTK_ArtificialPusher>();
        vRTK_ArtificialPusher.MinLimitExited += (object sender, ControllableEventArgs e) =>
        {
            CubeInstanciater.Instance.enabled = _construction;
            CubeRemover.Instance.enabled = !_construction;
            _construction = !_construction;
        };
    }
}
