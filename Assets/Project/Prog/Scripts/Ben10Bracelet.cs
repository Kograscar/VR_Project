using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using VRTK;
using VRTK.Controllables;
using VRTK.Controllables.ArtificialBased;
using UnityEngine.SceneManagement;

public class Ben10Bracelet : MonoBehaviour { 

    VRTK_ArtificialPusher _pusher;
    VRTK_ArtificialRotator _rotator;

    Animator _animator;

    float _timer;

    [SerializeField] string[] _tags = new string[4];
    
    VRTK_ControllerEvents _controller;

    void Start()
    {
        _pusher = GetComponentInChildren<VRTK_ArtificialPusher>();
        _rotator = GetComponentInChildren<VRTK_ArtificialRotator>();

        //_animator = GetComponent<Animator>();

        /*_pusher.MinLimitExited += (object sender, ControllableEventArgs e) =>
        {

        };*/

        /*_rotator.ValueChanged += (object sender, ControllableEventArgs e) =>
        {
            float a = Mathf.Atan2(_rotator.transform.up.x, _rotator.transform.up.y);
            a += Mathf.PI;
            a /= 2f * Mathf.PI;
            a = Mathf.RoundToInt(a * 100f);

            int quotient = Mathf.RoundToInt(a / 25);

            Debug.Log(quotient);

            if(quotient == 4)
            {
                CubeInstanciater.Instance.enabled = false;
                CubeRemover.Instance.enabled = true;
                Debug.Log("Delete");
            }
            else
            {
                CubeInstanciater.Instance.enabled = true;
                CubeRemover.Instance.enabled = false;
                CubeInstanciater.Instance.ChangeSelectedCube(_tags[quotient]);
                Debug.Log(_tags[quotient]);
            }
        };*/
    }

    private void Update()
    {
        if (_controller == null)
        {
            _controller = VRTK_DeviceFinder.DeviceTransform(VRTK_DeviceFinder.Devices.LeftController).GetComponent<VRTK_ControllerEvents>();
            if (_controller != null)
            {
                GetComponent<VRTK_TransformFollow>().gameObjectToFollow = _controller.gameObject;
            }
        }
    }

    private void LateUpdate()
    {
        transform.Rotate(0, 90, 0);
    }
}
