using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using VRTK.Controllables;
using VRTK.Controllables.ArtificialBased;

public class Ben10Bracelet : MonoBehaviour {

    VRTK_ArtificialPusher _pusher;
    VRTK_ArtificialRotator _rotator;

    [SerializeField] string[] _tags = new string[4];

    void Start()
    {
        _pusher = GetComponentInChildren<VRTK_ArtificialPusher>();
        _rotator = GetComponentInChildren<VRTK_ArtificialRotator>();

        _pusher.MinLimitExited += (object sender, ControllableEventArgs e) =>
        {
            Debug.Log("TURANSEFORMEEEEEE");
        };

        _rotator.ValueChanged += (object sender, ControllableEventArgs e) =>
        {
            float a = Mathf.Atan2(_rotator.transform.up.y, _rotator.transform.up.z);
            a += Mathf.PI;
            a /= 2f * Mathf.PI;
            a = Mathf.RoundToInt(a * 100f);

            //Debug.Log(a);

            int quotient = Mathf.RoundToInt(a / 25);

            //Debug.Log(quotient);

            if(quotient == 4)
            {
                CubeInstanciater.Instance.enabled = false;
                CubeRemover.Instance.enabled = true;
            }
            else
            {
                CubeInstanciater.Instance.enabled = true;
                CubeRemover.Instance.enabled = false;
                CubeInstanciater.Instance.ChangeSelectedCube(_tags[quotient]);
            }
        };
    }


}
