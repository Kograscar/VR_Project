using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using VRTK.Controllables;
using VRTK.Controllables.ArtificialBased;

public class CubeLoader : MonoBehaviour {

    VRTK_ArtificialPusher vrtk_ArtificialPusher;

    [SerializeField] int _green;
    [SerializeField] int _red;
    [SerializeField] int _yellow;
    [SerializeField] int _blue;
    [SerializeField] int _purple;
    [SerializeField] int _white;

    void Start()
    {
        vrtk_ArtificialPusher = GetComponent<VRTK_ArtificialPusher>();
        vrtk_ArtificialPusher.MinLimitExited += (object sender, ControllableEventArgs e) => 
        {
            CubeInstanciater.Instance.LoadCube(_green, _red, _yellow, _blue, _purple, _white);
        };
    }

    void LoadCube()
    {
        CubeInstanciater.Instance.LoadCube(_green, _red, _yellow, _blue, _purple, _white);
    }
}
