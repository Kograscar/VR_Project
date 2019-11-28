using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using VRTK.Controllables;
using VRTK.Controllables.ArtificialBased;

public class Ben10Bracelet : MonoBehaviour {

    VRTK_ArtificialPusher _pusher;
    VRTK_ArtificialRotator _rotator;

    Animator _animator;

    float _timer;

    bool _opening;

    [SerializeField] string[] _tags = new string[4];

    void Start()
    {
        _pusher = GetComponentInChildren<VRTK_ArtificialPusher>();
        _rotator = GetComponentInChildren<VRTK_ArtificialRotator>();

        //_animator = GetComponent<Animator>();

        _pusher.MinLimitExited += (object sender, ControllableEventArgs e) =>
        {
            //_animator.SetTrigger("Open");
            _opening = !_opening;
        };

        _rotator.ValueChanged += (object sender, ControllableEventArgs e) =>
        {
            float a = Mathf.Atan2(_rotator.transform.up.y, _rotator.transform.up.z);
            a += Mathf.PI;
            a /= 2f * Mathf.PI;
            a = Mathf.RoundToInt(a * 100f);

            int quotient = Mathf.RoundToInt(a / 25);

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

    private void Update()
    {
        if (!_opening)
        {
            CubeInstanciater.Instance.enabled = false;
            CubeRemover.Instance.enabled = false;
        }
        else
        {
            if (CubeRemover.Instance.enabled == false && CubeInstanciater.Instance.enabled == false)
            {
                float a = Mathf.Atan2(_rotator.transform.up.y, _rotator.transform.up.z);
                a += Mathf.PI;
                a /= 2f * Mathf.PI;
                a = Mathf.RoundToInt(a * 100f);

                int quotient = Mathf.RoundToInt(a / 25);

                if (quotient == 4)
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
            }
        }
    }
}
